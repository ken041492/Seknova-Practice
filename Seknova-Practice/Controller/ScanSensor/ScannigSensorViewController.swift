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
        btnTextInput.setTitle(NSLocalizedString("Input Text", comment: ""), for: .normal)
        btnSkip.setTitle(NSLocalizedString("Skip", comment: ""), for: .normal)
    }
    
    func setupNavigation() {
        title = "Scanning Sensor"
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.backBarButtonItem = nil
    }
    
    // MARK: - IBAction
    
    @IBAction func wordInput(_ sender: Any) {
        
        Alert().showDeviceIDInputAlert(vc: self,
                                       title: NSLocalizedString("Input Text", comment: ""),
                                       message: NSLocalizedString("Please enter the device ID", comment: ""),
                                       placeholder: NSLocalizedString("Please enter a 6-digit ID", comment: ""),
                                       onConfirm: { [self] deviceID in
            // 在确认按钮被点击时执行的操作
            // 处理用户输入的设备ID
//            print("用户输入的设备ID是：\(deviceID)")
            let isInputValid = isValidInput(deviceID)

            if isInputValid {
                // 用户输入了有效的设备ID，可以在这里处理
                print("用户输入的设备ID是：\(deviceID)")
                UserPreferences.shared.scaningID = deviceID
                let mainVC = TabbarViewController()
                self.navigationController?.pushViewController(mainVC,
                                                              animated: true)
            } else {
                Alert().showAlert(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Please enter a 6-digit ID", comment: ""), vc: self)
            }
        })
    }
    
    func isValidInput(_ input: String) -> Bool {
        let regexPattern = "^[A-F][0-9]{5}$"
        let regex = try! NSRegularExpression(pattern: regexPattern, options: [])
        let range = NSRange(location: 0, length: input.utf16.count)
        return regex.firstMatch(in: input, options: [], range: range) != nil
    }
}
// MARK: - Extension

// MARK: - Protocol


