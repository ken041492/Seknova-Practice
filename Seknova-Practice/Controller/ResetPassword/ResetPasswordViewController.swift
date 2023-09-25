//
//  ResetPasswordViewController.swift
//  Seknova-Practice
//
//  Created by imac-1682 on 2023/9/12.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var mail: UITextField!
    
    @IBOutlet weak var oldPassword: UITextField!
    
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var againPassword: UITextField!
    
    @IBOutlet weak var sendBTN: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var resetPwLabel: UILabel!
    
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
        setupLeftView(imageName: "mail", for: mail, width: 25, height: 20)
        // 設置password的圖像
        setupLeftView(imageName: "password", for: oldPassword, width: 25, height: 30)
        setupLeftView(imageName: "password", for: newPassword, width: 25, height: 30)
        setupLeftView(imageName: "password", for: againPassword, width: 25, height: 30)
        
        oldPassword.isSecureTextEntry = true
        newPassword.isSecureTextEntry = true
        againPassword.isSecureTextEntry = true
        
        sendBTN.setTitle("送出", for: .normal)
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
        mailText = mail.text!
    }
    
    @IBAction func oldPwChanged(_ sender: Any) {
        oldPwText = oldPassword.text!
    }
    @IBAction func newPwChanged(_ sender: Any) {
        newPwText = newPassword.text!
    }
    
    @IBAction func againPwChanged(_ sender: Any) {
        againPwText = againPassword.text!
    }
    
    @IBAction func backToLoginVC(_ sender: Any) {
        
        if mailText == "" || oldPwText == "" || newPwText == ""
            || againPwText == "" || !isPasswordValid(newPwText) {
            // 判斷信箱密碼正不正確
            if mailText != UserDefaults.standard.string(forKey: "mail") || oldPwText != UserDefaults.standard.string(forKey: "password") {
                let controller = UIAlertController(title: "錯誤",
                                                   message: "信箱或密碼錯誤",
                                                   preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                controller.addAction(okAction)
                present(controller, animated: true)
            } else {
                // 新設的密碼有錯誤或未填寫
                let controller = UIAlertController(title: "錯誤",
                                                   message: "有空格還未填寫",
                                                   preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                controller.addAction(okAction)
                present(controller, animated: true)
            }
        } else {
            // 一致就跳轉到重送驗證信頁面
            if (newPwText == againPwText) {
                
                UserDefaults.standard.set(newPwText, forKey: "password")
                navigationController?.popToRootViewController(animated: true)
            } else {
                let controller = UIAlertController(title: "密碼有誤!",
                                                   message: "輸入的密碼不一致",
                                                   preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                controller.addAction(okAction)
                present(controller, animated: true)
                
                newPassword.text = ""
                againPassword.text = ""
            }
        }
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
    
    
}
// MARK: - Extension

// MARK: - Protocol


