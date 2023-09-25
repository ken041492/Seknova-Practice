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
        forgotBTN.setTitle("忘記密碼", for: .normal)
        registerBTN.setTitle("註冊", for: .normal)
        signInBTN.setTitle("登入", for: .normal)

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
        navigationController?.navigationBar.tintColor = .white
        // 設定NavigationBar
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = UIColor.mainColor
        barAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        // 應用於導航欄的標準狀態
        navigationController?.navigationBar.standardAppearance = barAppearance
        // 應用於導航欄的滾動邊緣狀態
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }
    
    func setupLeftView(imageName: String, for textField: UITextField, width: CGFloat, height: CGFloat) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: width, height: height))
        imageView.image = UIImage(named: imageName)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        leftView.addSubview(imageView)
        
        textField.leftView = leftView
        textField.leftViewMode = .always
    }
    
    // MARK: - IBAction
    
    @IBAction func signInBTN(_ sender: Any) {
        
//        if mail.text != UserDefaults.standard.string(forKey: "mail") || password.text != UserDefaults.standard.string(forKey: "password") ||
//            !isEmailValid(mail.text!) || !isPasswordValid(password.text!) {
//
//            let controller = UIAlertController(title: "錯誤",
//                                               message: "信箱或密碼錯誤",
//                                               preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            controller.addAction(okAction)
//            present(controller, animated: true)
//        } else {
//            if UserDefaults.standard.string(forKey: "loginCount")! == "0" {
//                
//                let privacyBookVC = PrivacyBookViewController()
//                privacyBookVC.fontSize = 17.1
//                navigationController?.pushViewController(privacyBookVC, animated: true)
//            } else {
//                // go to main VC
//            }
//            UserDefaults.standard.set(Int(UserDefaults.standard.string(forKey: "loginCount")!)! + 1, forKey: "loginCount")
//        }
        
        let privacyBookVC = PrivacyBookViewController()
        privacyBookVC.fontSize = 17.1
        navigationController?.pushViewController(privacyBookVC, animated: true)
        
    }
    
    @IBAction func jumpToForgotVC(_ sender: Any) {
        
        let forgotPWVC = ForgotPasswordViewController()
        navigationController?.pushViewController(forgotPWVC, animated: true)
    }
    
    @IBAction func jumpToRegisterVC(_ sender: Any) {
        
        let RegisterVC = RegisterViewController()
        navigationController?.pushViewController(RegisterVC, animated: true)
    }
    
    func isPasswordValid(_ text: String) -> Bool {
//        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8}$"
        
//        let passwordRegex = "^(?=.*\\d{8,}).*[A-Za-z].*[A-Za-z].*$"
//        let passwordRegex = "^(?=.*\\d{8,})(?=.*[A-Za-z])(?=.*[A-Za-z]).*$"
        // ^ 開始 $ 結束
        // (?=.*[a-z]) 確保有一個a-z
        // (?=.*[A-Z]) 確保有一個A-Z
        // (?=.*\\d) 確保有一個數字
        // [a-zA-Z\\d]{8,}  由a-z, A-Z, 數字組成 最少8個字
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: text)
    }

    func isEmailValid(_ text: String) -> Bool {
        let mailRegex = "[A-Za-z0-9.-_]+@[A-Za-z0-9._]+\\.[A-Za-z]{2,3}"
        let mailTest = NSPredicate(format: "SELF MATCHES %@", mailRegex)
        return mailTest.evaluate(with: text)
    }
}
// MARK: - Extension

// MARK: - Protocol


