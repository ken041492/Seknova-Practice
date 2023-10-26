//
//  ScannigSensorViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/28.
//

import UIKit

class ScannigSensorViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var btnTextInput: UIButton!
    
    @IBOutlet weak var btnSkip: UIButton!
    
    // MARK: - Variables
       
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
        btnTextInput.setTitle("文字輸入", for: .normal)
        btnSkip.setTitle("略過", for: .normal)
    }
    
    func setupNavigation() {
        title = "Scanning Sensor"
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.backBarButtonItem = nil
    }
    
    // MARK: - IBAction
    
    @IBAction func wordInput(_ sender: Any) {
        
        Alert().showDeviceIDInputAlert(vc: self,
                                       title: "文字輸入",
                                       message: "請輸入裝置ID",
                                       placeholder: "輸入裝置ID後六碼",
                                       onConfirm: { deviceID in
            // 在确认按钮被点击时执行的操作
            // 处理用户输入的设备ID
//            print("用户输入的设备ID是：\(deviceID)")
            let isInputValid = deviceID.count == 6 &&
                deviceID.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil

            if isInputValid {
                // 用户输入了有效的设备ID，可以在这里处理
                print("用户输入的设备ID是：\(deviceID)")
                UserPreferences.shared.scaningID = deviceID
                let mainVC = TabbarViewController()
                self.navigationController?.pushViewController(mainVC,
                                                              animated: true)
            } else {
                Alert().showAlert(title: "錯誤", message: "請輸入ID後六碼", vc: self)
            }
        })
    }
}
// MARK: - Extension

// MARK: - Protocol


