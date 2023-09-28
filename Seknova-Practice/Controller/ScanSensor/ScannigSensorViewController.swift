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
        
    }
    
    // MARK: - IBAction
    
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
//                if UserPreferences.shared.deviceID !=  textField.text! {
//                    let controller = UIAlertController(title: "錯誤",
//                                                       message: "裝置碼錯誤",
//                                                       preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: "OK",
//                                                 style: .default)
//                    controller.addAction(okAction)
//                    present(controller, animated: true)
//                } else {
//                    // go to mainVC
//                }
//            }
            
            if let textField = alertController.textFields?.first,
               let inputText = textField.text {
                // 检查输入是否为 6 位数字
                let isInputValid = inputText.count == 6 && inputText.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil

                if isInputValid {
                    // 用户输入合法，处理用户输入
                    if inputText != UserPreferences.shared.deviceID {
                        let controller = UIAlertController(title: "錯誤",
                                                           message: "裝置碼錯誤",
                                                           preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK",
                                                     style: .default)
                        controller.addAction(okAction)
                        present(controller, animated: true)
                    } else {
                        // go to mainVC
                    }
                } else {
                    let controller = UIAlertController(title: "錯誤",
                                                       message: "請輸入ID後六碼",
                                                       preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    controller.addAction(okAction)
                    present(controller, animated: true)
                }
            }
        }
        alertController.addAction(confirmAction)
        // 在视图控制器中显示警告视图
        present(alertController, animated: true, completion: nil)
    }
}
// MARK: - Extension

// MARK: - Protocol


