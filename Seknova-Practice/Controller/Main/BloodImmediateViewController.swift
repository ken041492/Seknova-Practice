//
//  BloodImmediateViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/28.
//

import UIKit

import CoreBluetooth

import Charts

class BloodImmediateViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var lbBloodSugar: UILabel!
    
    // MARK: - Variables
    
    let imageSize = CGSize(width: 40, height: 40) // 指定所需的圖片大小
    
    var networkMonitor: NetworkMonitor?

    var centralManager: CBCentralManager!
    
    var navigationBlueTooth: UIBarButtonItem!
    
    var navigationNetwork: UIBarButtonItem!
    
    var judgeNetwork: Bool = false
    
    var judgeBlueTooth: Bool = false
    // 判斷網路的計時器
    var timer: Timer?
    // 讓血糖值可以亂數
    var timer2: Timer?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        centralManager = CBCentralManager(delegate: self, queue: nil)


        setupUI()
        
        // 在视图控制器的 viewDidLoad 方法中创建 NetworkMonitor 实例
        networkMonitor = NetworkMonitor()

        // 在需要检查网络连接的地方使用 networkMonitor
        // 例如，你可以在某个按钮点击事件中检查网络连接：
        checkNetworkConnection()
        
        timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(randomSugarBlood), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(67890)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
    }
    
    func setupNavigation() {

//        let imageSize = CGSize(width: 40, height: 40) // 指定所需的圖片大小
//
//        let imgNetworkCheck = resizeImage(image: UIImage(named: "network-check")!.withRenderingMode(.alwaysOriginal),
//                                  targetSize: imageSize)

//        let imgBluetoothCheck = resizeImage(image: UIImage(named: "bluetooth-check")!.withRenderingMode(.alwaysOriginal),
//                                       targetSize: CGSize(width: 40, height: 40))
        
//        let imageSize = CGSize(width: 40, height: 40) // 指定所需的圖片大小
//
//        let imgNetworkCheck = resizeImage(image: UIImage(named: "network-check")!.withRenderingMode(.alwaysOriginal),
//                                  targetSize: imageSize)
        
//        let btnNetwork = UIButton(type: .custom)
//            btnNetwork.setImage(imgNetworkCheck, for: .normal)
//            btnNetwork.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//            btnNetwork.addTarget(self,
//                                   action: #selector(button1Tapped),
//                                   for: .touchUpInside)
        
//        let btnBlueTooth = UIButton(type: .custom)
//        btnBlueTooth.setImage(imgBluetoothCheck, for: .normal)
//        btnBlueTooth.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        btnBlueTooth.addTarget(self,
//                          action: #selector(button2Tapped),
//                          for: .touchUpInside)
        
//        navigationBlueTooth = UIBarButtonItem(customView: btnBlueTooth)
//        navigationNetwork = UIBarButtonItem(customView: btnNetwork)
        
//        navigationItem.rightBarButtonItems = [navigationBlueTooth, navigationNetwork]
        
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // 確定保持原始圖片的寬高比例，並根據較小的比例來縮放圖片
        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        // 根據目標大小和新尺寸縮放圖片
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func checkNetworkConnection() {
        if let monitor = networkMonitor {
            // 在此处检查网络连接
            // 你可以根据 monitor 的状态来执行相应的操作
                        
            let imgNetworkCheck = resizeImage(image: UIImage(named: "network-check")!.withRenderingMode(.alwaysOriginal),
                                      targetSize: imageSize)
            
            let imgNetworkFalse = resizeImage(image: UIImage(named: "network-false")!.withRenderingMode(.alwaysOriginal),
                                      targetSize: imageSize)
            
            let btnNetwork = UIButton(type: .custom)
            btnNetwork.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            
            if monitor.isConnectedToInternet {
                
                btnNetwork.setImage(imgNetworkCheck, for: .normal)
                btnNetwork.addTarget(self,
                                     action: #selector(button1Tapped),
                                     for: .touchUpInside)
                judgeNetwork = true
                print("设备已连接到互联网")
            } else {
                
                btnNetwork.setImage(imgNetworkFalse, for: .normal)
                btnNetwork.addTarget(self,
                                       action: #selector(button1Tapped),
                                       for: .touchUpInside)
                judgeNetwork = false
                print("设备未连接到互联网")
            }
            navigationNetwork = UIBarButtonItem(customView: btnNetwork)
        } else {
            // 如果 networkMonitor 为空，则未成功创建
            print("无法检查网络连接，因为 networkMonitor 未初始化")
        }
    }
    
    // MARK: - IBAction
    
    @objc func button1Tapped() {
        // 处理按钮1的点击事件
    }

    @objc func button2Tapped() {
        // 处理按钮2的点击事件
    }
    
    @objc func backButtonTapped() {
        // 处理返回按钮的点击事件
    }
    
    @objc func checkNetworkTimer() {
        checkNetworkConnection()
        navigationItem.rightBarButtonItems = [navigationBlueTooth, navigationNetwork]
    }
    
    @objc func randomSugarBlood() {
        lbBloodSugar.text = "\(Int.random(in: 65..<250))"
    }
}
// MARK: - Extension
extension BloodImmediateViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        let imgBluetoothCheck = resizeImage(image: UIImage(named: "bluetooth-check")!.withRenderingMode(.alwaysOriginal),
                                       targetSize: CGSize(width: 40, height: 40))
        
        let imgBluetoothFalse = resizeImage(image: UIImage(named: "bluetooth-false")!.withRenderingMode(.alwaysOriginal),
                                       targetSize: CGSize(width: 40, height: 40))
        
        let btnBlueTooth = UIButton(type: .custom)
        btnBlueTooth.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        switch central.state {
        case .unknown:
            print("蓝牙状态未知")
        case .resetting:
            print("蓝牙状态重置中")
        case .unsupported:
            print("不支持蓝牙")
        case .unauthorized:
            print("蓝牙未授权")
        case .poweredOff:
            
            btnBlueTooth.setImage(imgBluetoothFalse, for: .normal)
            btnBlueTooth.addTarget(self,
                                 action: #selector(button1Tapped),
                                 for: .touchUpInside)
            judgeBlueTooth = false
            print("蓝牙已关闭")
        case .poweredOn:
            
            btnBlueTooth.setImage(imgBluetoothCheck, for: .normal)
            btnBlueTooth.addTarget(self,
                                 action: #selector(button1Tapped),
                                 for: .touchUpInside)
            judgeBlueTooth = true
            print("蓝牙已开启")
        @unknown default:
            print("蓝牙状态未知")
        }
        navigationBlueTooth = UIBarButtonItem(customView: btnBlueTooth)
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(checkNetworkTimer), userInfo: nil, repeats: true)
        navigationItem.rightBarButtonItems = [navigationBlueTooth, navigationNetwork]
    }
}
// MARK: - Protocol


