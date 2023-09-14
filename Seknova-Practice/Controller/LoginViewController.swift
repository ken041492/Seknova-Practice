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
        setupLeftView(imageName: "mail", for: mail, width: 25, height: 20)
        // 設置password的圖像
        setupLeftView(imageName: "password", for: password, width: 20, height: 20)
        
        // 設置每個按鈕的style
        setupButtonStyle(for: forgotBTN, title: "忘記密碼")
        setupButtonStyle(for: registerBTN, title: "註冊")
        setupButtonStyle(for: signInBTN, title: "登入")
        
        // GoogleBTN的左右兩邊圓滑
        googleSignInBTN.layer.cornerRadius = googleSignInBTN.frame.height / 2
        googleSignInBTN.layer.borderWidth = 1
        
        // Google按鈕 設定 圖片+文字
        let content = NSMutableAttributedString(string: "")
        let Attachment = NSTextAttachment()
        Attachment.image = UIImage(named: "google")
        Attachment.bounds = CGRect(x: 0, y: -2, width: 35, height: 35)
        content.append(NSAttributedString(string: "    "))
        content.append(NSAttributedString(attachment: Attachment))
        content.append(NSAttributedString(string: "     Google 登入", attributes: [NSAttributedString.Key.baselineOffset: 10]))
        googleSignInBTN.setAttributedTitle(content, for: .normal)
                
    }
    
    func setupNavigation() {
        navigationItem.title = "Login"
        // 設定NavigationBar
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                                blue: 36.0 / 255.0, alpha: 1.0)
        barAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        // 應用於導航欄的標準狀態
        navigationController?.navigationBar.standardAppearance = barAppearance
        // 應用於導航欄的滾動邊緣狀態
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupLeftView(imageName: String, for textField: UITextField, width: CGFloat, height: CGFloat) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: width, height: height))
        imageView.image = UIImage(named: imageName)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        leftView.addSubview(imageView)
        
        textField.leftView = leftView
        textField.leftViewMode = .always
    }
    
    func setupButtonStyle(for button: UIButton, title: String) {
        
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.borderWidth = 5.0
        button.layer.borderColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0).cgColor
        button.setTitle(title, for: .normal)
        button.tintColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
    }
    
    // MARK: - IBAction
    @IBAction func jumpToForgotVC(_ sender: Any) {
        
        let ForgotPWVC = ForgotPasswordViewController()
//        let backButton = UIBarButtonItem()
//        navigationItem.backBarButtonItem = backButton
//        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(ForgotPWVC, animated: true)
    }
    
    @IBAction func jumpToRegisterVC(_ sender: Any) {
        
        let RegisterVC = RegisterViewController()
//        let backButton = UIBarButtonItem()
//        navigationItem.backBarButtonItem = backButton
//        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(RegisterVC, animated: true)
    }
}
// MARK: - Extension

// MARK: - Protocol


