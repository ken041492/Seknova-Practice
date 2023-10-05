//
//  ForgotPasswordViewController.swift
//  Seknova-Practice
//
//  Created by imac-1682 on 2023/9/12.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var imgvForgotPwBackground: UIImageView!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbForgotPw: UILabel!
    
    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet weak var vBackground: UIView!
    
    @IBOutlet weak var blMention: UILabel!
    
    @IBOutlet weak var txfMail: UITextField!
    
    @IBOutlet weak var vBottomLine: UIView!
    
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
        view.sendSubviewToBack(imgvForgotPwBackground)
        btnSend.setTitle("送出", for: .normal)
        
        vBackground.layer.shadowColor = UIColor.gray.cgColor // 设置阴影颜色
        vBackground.layer.shadowOffset = CGSize(width: 0, height: 0) // 设置阴影偏移
        vBackground.layer.shadowRadius = 6.0 // 设置阴影半径
        vBackground.layer.shadowOpacity = 0.9 // 设置阴影透明度
        
        
    }
    
    func setupNavigation() {
        navigationItem.title = "FORGOT PASSWORD"
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - IBAction
    @IBAction func jumpToResetPwVC(_ sender: Any) {
        if txfMail.text != UserPreferences.shared.userMail {
            Alert().showAlert(title: "錯誤",
                              message: "無此信箱或未填寫",
                              vc: self,
                              okActionHandler: nil)
        } else {
            let resetPwVC = ResetPasswordViewController()
            navigationController?.pushViewController(resetPwVC, animated: true)
        }
    }
    
}
// MARK: - Extension

// MARK: - Protocol


