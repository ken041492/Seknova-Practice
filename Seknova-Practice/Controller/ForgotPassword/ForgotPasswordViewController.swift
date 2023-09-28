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
        sendBTN.setTitle("送出", for: .normal)
        
        backgroundView.layer.shadowColor = UIColor.gray.cgColor // 设置阴影颜色
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0) // 设置阴影偏移
        backgroundView.layer.shadowRadius = 6.0 // 设置阴影半径
        backgroundView.layer.shadowOpacity = 0.9 // 设置阴影透明度
        
        
    }
    
    func setupNavigation() {
        navigationItem.title = "FORGOT PASSWORD"
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - IBAction
    @IBAction func jumpToResetPwVC(_ sender: Any) {
        if mail.text != UserPreferences.shared.userMail {
            let controller = UIAlertController(title: "錯誤",
                                               message: "無此信箱或未填寫",
                                               preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true)
        } else {
            let resetPwVC = ResetPasswordViewController()
            navigationController?.pushViewController(resetPwVC, animated: true)
        }
    }
    
}
// MARK: - Extension

// MARK: - Protocol


