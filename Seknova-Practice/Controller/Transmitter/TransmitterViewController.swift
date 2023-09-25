//
//  TransmitterViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/24.
//

import UIKit

class TransmitterViewController: UIViewController {
    
    // MARK: - IBOutlet
  
    @IBOutlet weak var transmitterImageA: UIImageView!
    
    @IBOutlet weak var transmitterImageB: UIImageView!
    
    @IBOutlet weak var qrScanBTN: UIButton!
    
    @IBOutlet weak var wordInputBTN: UIButton!
    
    @IBOutlet weak var backBTN: UIButton!
    
    // MARK: - Variables
    var storeText: String = ""
    
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
            if let textField = alertController.textFields?.first {
                // 获取用户输入的文本
                storeText = textField.text!
                // 在这里处理用户输入
            }
            let pairBTVC = PairBlueToothViewController()
            navigationController?.pushViewController(pairBTVC, animated: true)
        }
        alertController.addAction(confirmAction)
        // 在视图控制器中显示警告视图
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func back(_ sender: Any) {
        print(storeText)
    }
    
    
}
// MARK: - Extension

// MARK: - Protocol


