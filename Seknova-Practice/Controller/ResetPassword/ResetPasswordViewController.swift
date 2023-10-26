//
//  ResetPasswordViewController.swift
//  Seknova-Practice
//
//  Created by imac-1682 on 2023/9/12.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var txfMail: UITextField!
    
    @IBOutlet weak var txfOldPassword: UITextField!
    
    @IBOutlet weak var txfNewPassword: UITextField!
    
    @IBOutlet weak var txfAgainPassword: UITextField!
    
    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbResetPw: UILabel!
    
    // MARK: - Variables
    var mailText: String = ""
    var oldPwText: String = ""
    var newPwText: String = ""
    var againPwText: String = ""
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
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
        // 設置mail的圖像
        setupLeftView(imageName: "mail", for: txfMail, width: 25, height: 20)
        // 設置password的圖像
        setupLeftView(imageName: "password", for: txfOldPassword, width: 25, height: 30)
        setupLeftView(imageName: "password", for: txfNewPassword, width: 25, height: 30)
        setupLeftView(imageName: "password", for: txfAgainPassword, width: 25, height: 30)
        
        txfOldPassword.isSecureTextEntry = true
        txfNewPassword.isSecureTextEntry = true
        txfAgainPassword.isSecureTextEntry = true
        
        btnSend.setTitle("送出", for: .normal)
    }
    
    func setupLeftView(imageName: String, for textField: UITextField, width: CGFloat, height: CGFloat) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: width, height: height))
        imageView.image = UIImage(named: imageName)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: height))
        leftView.addSubview(imageView)
        
        textField.leftView = leftView
        textField.leftViewMode = .always
    }
    
    // MARK: - IBAction
    
    @IBAction func mailChanged(_ sender: Any) {
        mailText = txfMail.text!
    }
    
    @IBAction func oldPwChanged(_ sender: Any) {
        oldPwText = txfOldPassword.text!
    }
    @IBAction func newPwChanged(_ sender: Any) {
        newPwText = txfNewPassword.text!
    }
    
    @IBAction func againPwChanged(_ sender: Any) {
        againPwText = txfAgainPassword.text!
    }
    
    @IBAction func backToLoginVC(_ sender: Any) {
        
        if mailText == "" || oldPwText == "" || newPwText == ""
            || againPwText == "" || !isPasswordValid(newPwText) || (newPwText != againPwText) {
            // 判斷信箱密碼正不正確
            Alert().showAlert(title: "帳號密碼或更改格式錯誤",
                              message: "電子信箱錯誤\n密碼錯誤\n密碼格式錯誤\n密碼不一致",
                              vc: self)
        } else {
            // 一致就跳轉到重送驗證信頁面
            UserPreferences.shared.userPassword = newPwText
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func isPasswordValid(_ text: String) -> Bool {
        // ^ 開始 $ 結束
        // (?=.*[a-z]) 確保有一個a-z
        // (?=.*[A-Z]) 確保有一個A-Z
        // (?=.*\\d) 確保有一個數字
        // [a-zA-Z\\d]{8,}  由a-z, A-Z, 數字組成 最少8個字
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: text)
    }
}
// MARK: - Extension

// MARK: - Protocol


