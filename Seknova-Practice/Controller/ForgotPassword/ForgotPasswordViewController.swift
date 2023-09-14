//
//  ForgotPasswordViewController.swift
//  Seknova-Practice
//
//  Created by imac-1682 on 2023/9/12.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var forgotPwBackground: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var forgotPwLabel: UILabel!
    
    @IBOutlet weak var sendBTN: UIButton!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var mentionLabel: UILabel!
    
    @IBOutlet weak var mail: UITextField!
    
    @IBOutlet weak var bottomLine: UIView!
    
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
        view.sendSubviewToBack(forgotPwBackground)
        // 改變 Label 文字顏色
        titleLabel.textColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                       blue: 36.0 / 255.0, alpha: 1.0)
        forgotPwLabel.textColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                          blue: 36.0 / 255.0, alpha: 1.0)
        mentionLabel.textColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                         blue: 36.0 / 255.0, alpha: 1.0)
        bottomLine.backgroundColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                             blue: 36.0 / 255.0, alpha: 1.0)
        
        sendBTN.layer.cornerRadius = sendBTN.frame.height / 2
        // 設定 forgotPassword BTN
        sendBTN.layer.borderWidth = 5.0 // 设置边框宽度
        sendBTN.layer.borderColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                              blue: 36.0 / 255.0, alpha: 1.0).cgColor
        sendBTN.setTitle("送出", for: .normal)
        sendBTN.tintColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                      blue: 36.0 / 255.0, alpha: 1.0)
        
        backgroundView.layer.shadowColor = UIColor.gray.cgColor // 设置阴影颜色
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 2) // 设置阴影偏移
        backgroundView.layer.shadowRadius = 4.0 // 设置阴影半径
        backgroundView.layer.shadowOpacity = 0.5 // 设置阴影透明度
    }
    
    func setupNavigation() {
        title = "FORGOT PASSWORD"

    }
    
    // MARK: - IBAction
    @IBAction func jumpToResetPwVC(_ sender: Any) {
        let resetPwVC = ResetPasswordViewController()
        let backButton = UIBarButtonItem()
        navigationItem.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(resetPwVC, animated: true)
    }
    
}
// MARK: - Extension

// MARK: - Protocol


