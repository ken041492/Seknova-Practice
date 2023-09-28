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
  
    @IBOutlet weak var transmitterImageA: UIImageView!
    
    @IBOutlet weak var transmitterImageB: UIImageView!
    
    @IBOutlet weak var qrScanBTN: UIButton!
    
    @IBOutlet weak var wordInputBTN: UIButton!
    
    @IBOutlet weak var backBTN: UIButton!
    
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
        
//        if didProcessQRCode {
//                // 啟用QR Code相機，開始掃描
//            configurationScanner()
//        }
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
        qrScanBTN.setTitle("QR掃描", for: .normal)
        wordInputBTN.setTitle("文字輸入", for: .normal)
        backBTN.setTitle("返回", for: .normal)
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
        
        // 创建一个 UIAlertController
        let alertController = UIAlertController(title: "文字輸入", message: "請輸入裝置ID", preferredStyle: .alert)

        // 添加一个文本框到警告视图中
        alertController.addTextField { (textField) in
            textField.placeholder = "輸入裝置ID後六碼"
        }

        // 添加取消按钮
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        // 添加确认按钮
        let confirmAction = UIAlertAction(title: "確認", style: .default) { [self] (_) in
//            if let textField = alertController.textFields?.first {
//                // 获取用户输入的文本
//                storeText = textField.text!
//                // 在这里处理用户输入
//            }
            
            if let textField = alertController.textFields?.first,
               let inputText = textField.text {
                // 检查输入是否为 6 位数字
                let isInputValid = inputText.count == 6 && inputText.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil

                if isInputValid {
                    // 用户输入合法，处理用户输入
//                    storeText = inputText
                    UserPreferences.shared.deviceID = inputText
                    // 在这里处理用户确认操作，例如跳转页面
                    let pairBTVC = PairBlueToothViewController()
                    navigationController?.pushViewController(pairBTVC, animated: true)
                } else {
                    let controller = UIAlertController(title: "錯誤",
                                                       message: "請輸入ID後六碼",
                                                       preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    controller.addAction(okAction)
                    present(controller, animated: true)
                }
            }
            
//            let pairBTVC = PairBlueToothViewController()
//            navigationController?.pushViewController(pairBTVC, animated: true)
        }
        alertController.addAction(confirmAction)
        // 在视图控制器中显示警告视图
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func back(_ sender: Any) {
//        print(storeText)

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
            // 設置影片在 videoPreivewLayer 的顯示方式
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
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
        
//        if didProcessQRCode { // 如果已處理過QRCode，不再處理
//            return
//        }
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
//                  detectedQRCodeValue = value // 将QR码值保存到变量中
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


