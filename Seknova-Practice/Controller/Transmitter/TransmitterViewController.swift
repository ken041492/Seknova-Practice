//
//  TransmitterViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/24.
//

import UIKit
import AVFoundation


class TransmitterViewController: UIViewController {
    
    // MARK: - IBOutlet
  
    @IBOutlet weak var imgvTransmitterA: UIImageView!
    
    @IBOutlet weak var imgvTransmitterB: UIImageView!
    
    @IBOutlet weak var btnQrScan: UIButton!
    
    @IBOutlet weak var btnWordInput: UIButton!
    
    @IBOutlet weak var btnBack: UIButton!
    
    // MARK: - Variables
    var storeText: String = ""
    // 用來管理擷取活動和協調輸入及輸出數據流的對象。
    var captureSession: AVCaptureSession?
    // 核心動畫層，可以在擷取視頻時顯示視頻。
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    // 稍後我們為了替我們的 QR Code 加上掃描框使用。
    var qrCodeFrameView: UIView?
    
//    var detectedQRCodeValue: String?

    var didProcessQRCode = false // 添加一個標誌來檢查是否已處理QRCode

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        btnQrScan.setTitle("QR掃描", for: .normal)
        btnWordInput.setTitle("文字輸入", for: .normal)
        btnBack.setTitle("返回", for: .normal)
        imgvTransmitterA.isHidden = false
        imgvTransmitterB.isHidden = false
    }
    
    func setupNavigation() {
        title = "Scanning Transmitter"
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.backBarButtonItem = nil
    }
    
    // MARK: - IBAction
    
    @IBAction func qrScan(_ sender: Any) {
        configurationScanner()
    }
    
    @IBAction func wordInput(_ sender: Any) {
        imgvTransmitterA.isHidden = true
        imgvTransmitterB.isHidden = true
        
        Alert().showDeviceIDInputAlert(vc: self, onCancel: {
            // 在取消按钮被点击时执行的操作
            self.imgvTransmitterA.isHidden = false
            self.imgvTransmitterB.isHidden = false
        }, onConfirm: { deviceID in
            // 在确认按钮被点击时执行的操作
            // 处理用户输入的设备ID
//            print("用户输入的设备ID是：\(deviceID)")
            let isInputValid = deviceID.count == 6 &&
                deviceID.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil

            if isInputValid {
                // 用户输入了有效的设备ID，可以在这里处理
                print("用户输入的设备ID是：\(deviceID)")
                UserPreferences.shared.deviceID = deviceID
                let pairBTVC = PairBlueToothViewController()
                self.navigationController?.pushViewController(pairBTVC, animated: true)
                self.imgvTransmitterA.isHidden = false
                self.imgvTransmitterB.isHidden = false
            } else {
                // 用户输入无效，显示错误提示
                self.imgvTransmitterA.isHidden = false
                self.imgvTransmitterB.isHidden = false
                Alert().showAlert(title: "錯誤", message: "請輸入ID後六碼", vc: self)
            }
        })
    }
    
    
    @IBAction func back(_ sender: Any) {

        UserPreferences.shared.userMail = ""
        UserPreferences.shared.userPassword = ""
        UserPreferences.shared.loginCount = 0
        self.navigationController?.popToRootViewController(animated: true)

    }
    
    func configurationScanner() {
        // 取得後置鏡頭來擷取影片
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("無法獲取相機裝置")
            return
        }
        do {
            // 使用前一個裝置物件 captureDevice 來取得 AVCaptureDeviceInput 類別的實例
            let input = try AVCaptureDeviceInput(device: captureDevice)
            // 實例化 AVCaptureSession，設定 captureSession 的輸入裝置
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            // 實例化 AVCaptureMetadataOutput 物件並將其設定做為 captureSession 的輸出
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            // 設置 delegate 為 self，並使用預設的調度佇列來執行 Call back
            // 當一個新的元資料被擷取時，便會將其轉交給委派物件做進一步處理
            // 依照 Apple 的文件，我們這邊使用 DispatchQueue.main 來取得預設的主佇列
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            // 告訴 App 我們所想要處理 metadata 的對象對象類型
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            // 用於顯示我們的相機畫面
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            
            let screenSize = UIScreen.main.bounds.size
            let desiredWidth: CGFloat = screenSize.width * 0.8 // 设置视窗的宽度为屏幕宽度的 80%
            let desiredHeight: CGFloat = screenSize.height * 0.5 // 设置视窗的高度为屏幕高度的 40%
            let xOrigin = (screenSize.width - desiredWidth) / 2
            let yOrigin = (screenSize.height - desiredHeight) / 2
            videoPreviewLayer?.frame = CGRect(x: xOrigin, y: yOrigin, width: desiredWidth, height: desiredHeight)
            
            
            
            // 設置影片在 videoPreivewLayer 的顯示方式
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            view.layer.addSublayer(videoPreviewLayer!)
            // 設置 QR Code 掃描框
            settingScannerFrame()
            // 開始擷取畫面
//            captureSession!.startRunning()
            DispatchQueue.global(qos: .background).async {
                self.captureSession?.startRunning()
            }
        } catch {
            // 假如有錯誤發生、印出錯誤描述並且 return
            print(error.localizedDescription)
            return
        }
    }
    
    func settingScannerFrame() {
        qrCodeFrameView = UIView()
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            // 將 qrCodeFrameView 排至畫面最前方
            view.bringSubviewToFront(qrCodeFrameView)
        }
    }
}
// MARK: - Extension

extension TransmitterViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
      // 如果 metadataObjects 是空陣列
      // 那麼將我們搜尋框的 frame 設為 zero，並且 return
      if metadataObjects.isEmpty {
          qrCodeFrameView?.frame = CGRect.zero
          return
      }
      // 如果能夠取得 metadataObjects 並且能夠轉換成 AVMetadataMachineReadableCodeObject（條碼訊息）
      if let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
          // 判斷 metadataObj 的類型是否為 QR Code
          if metadataObj.type == AVMetadataObject.ObjectType.qr {
              //  如果 metadata 與 QR code metadata 相同，則更新搜尋框的 frame
              let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
              qrCodeFrameView?.frame = barCodeObject!.bounds
              if let value = metadataObj.stringValue {
                  UserPreferences.shared.deviceID = value
                  didProcessQRCode = true
                  
                  captureSession?.stopRunning()
                  videoPreviewLayer?.isHidden = true
                  qrCodeFrameView?.removeFromSuperview()
                  
                  let pairBTVC = PairBlueToothViewController()
                  navigationController?.pushViewController(pairBTVC, animated: true)
              }
          }
      }
    }
}

// MARK: - Protocol


