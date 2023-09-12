//
//  LoginViewController.swift
//  Seknova-Practice
//
//  Created by imac-1682 on 2023/9/11.
//

import UIKit
import SwiftUI

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var loginBackground: UIImageView!
    
    @IBOutlet weak var mail: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signInBTN: UIButton!
    
    @IBOutlet weak var fbSignInBTN: UIButton!
    
    @IBOutlet weak var appleSignInBTN: UIButton!
    
    @IBOutlet weak var googleSignInBTN: UIButton!
    
    @IBOutlet weak var forgotBTN: UIButton!
    
    @IBOutlet weak var registerBTN: UIButton!
    
    
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
        
        // 設置背景圖
        view.sendSubviewToBack(loginBackground)
        // 設置mail的圖像
        let mailImage = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        mailImage.image = UIImage(named: "mail")
        let mailLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        mailLeftView.addSubview(mailImage)
        mail.leftView = mailLeftView
        mail.leftViewMode = .always
        // 增加陰影的效果
        mail.layer.shadowColor = UIColor.gray.cgColor // 設置陰影顏色
        mail.layer.shadowOffset = CGSize(width: 0, height: 2) // 設置陰影偏移
        mail.layer.shadowRadius = 4.0 // 設置陰影半徑
        mail.layer.shadowOpacity = 0.5 // 設置陰影透明度
        
        // 設置password的圖像
        let passwordImage = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        passwordImage.image = UIImage(named: "password") // 設置小圖片的圖像
        let passwordLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        passwordLeftView.addSubview(passwordImage)
        password.leftView = passwordLeftView
        password.leftViewMode = .always
        // 增加陰影的效果
        password.layer.shadowColor = UIColor.gray.cgColor // 设置阴影颜色
        password.layer.shadowOffset = CGSize(width: 0, height: 2) // 设置阴影偏移
        password.layer.shadowRadius = 4.0 // 设置阴影半径
        password.layer.shadowOpacity = 0.5 // 设置阴影透明度
        
        // GoogleBTN的左右兩邊圓滑
        googleSignInBTN.layer.cornerRadius = googleSignInBTN.frame.height / 2
        googleSignInBTN.layer.borderWidth = 1
        
        // FB按鈕 設定圖片+文字
        var content = NSMutableAttributedString(string: "")
        var Attachment = NSTextAttachment()
        Attachment.image = UIImage(named: "facebook")
        Attachment.bounds = CGRect(x: 0, y: -2, width: 30, height: 30)
        content.append(NSAttributedString(string: "   "))
        content.append(NSAttributedString(attachment: Attachment))
        content.append(NSAttributedString(string: "   Facebook 登入", attributes: [NSAttributedString.Key.baselineOffset: 5]))
        fbSignInBTN.setAttributedTitle(content, for: .normal)
        
        // Google按鈕 設定 圖片+文字
        content = NSMutableAttributedString(string: "")
        Attachment = NSTextAttachment()
        Attachment.image = UIImage(named: "google")
        Attachment.bounds = CGRect(x: 0, y: -2, width: 35, height: 35)
        content.append(NSAttributedString(string: "    "))
        content.append(NSAttributedString(attachment: Attachment))
        content.append(NSAttributedString(string: "     Google 登入", attributes: [NSAttributedString.Key.baselineOffset: 10]))
        googleSignInBTN.setAttributedTitle(content, for: .normal)
        
        // 设置按钮的圆角
        forgotBTN.layer.cornerRadius = forgotBTN.frame.height / 2
        // 設定 forgotPassword BTN
        forgotBTN.layer.borderWidth = 5.0 // 设置边框宽度
        forgotBTN.layer.borderColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                              blue: 36.0 / 255.0, alpha: 1.0).cgColor
        forgotBTN.setTitle("忘記密碼", for: .normal)
        forgotBTN.tintColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                      blue: 36.0 / 255.0, alpha: 1.0)

        // 设置按钮的圆角
        registerBTN.layer.cornerRadius = registerBTN.frame.height / 2
        // 設定 forgotPassword BTN
        registerBTN.layer.borderWidth = 5.0 // 设置边框宽度
        registerBTN.layer.borderColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                              blue: 36.0 / 255.0, alpha: 1.0).cgColor
        registerBTN.setTitle("註冊", for: .normal)
        registerBTN.tintColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                      blue: 36.0 / 255.0, alpha: 1.0)
        
    }
    
    func setupNavigation() {
        title = "Login"
        // 設定NavigationBar
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                                blue: 36.0 / 255.0, alpha: 1.0)
        barAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        // 應用於導航欄的標準狀態
        navigationController?.navigationBar.standardAppearance = barAppearance
        // 應用於導航欄的滾動邊緣狀態
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        
    }
    
    // MARK: - IBAction
    @IBAction func jumpToForgotVC(_ sender: Any) {
        
        let ForgotPWVC = ForgotPasswordViewController()
        let backButton = UIBarButtonItem()
        navigationItem.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(ForgotPWVC, animated: true)
    }
    
    @IBAction func jumpToRegisterVC(_ sender: Any) {
        
        let RegisterVC = RegisterViewController()
        let backButton = UIBarButtonItem()
        navigationItem.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(RegisterVC, animated: true)
    }
}
// MARK: - Extension

// MARK: - Protocol


