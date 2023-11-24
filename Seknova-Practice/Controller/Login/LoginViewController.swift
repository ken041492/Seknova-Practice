//
//  LoginViewController.swift
//  Seknova-Practice
//
//  Created by imac-1682 on 2023/9/11.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var imgvLoginBackground: UIImageView!
    
    @IBOutlet weak var txfMail: UITextField!
    
    @IBOutlet weak var txfPassword: UITextField!
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var btnFbSignIn: UIButton!
    
    @IBOutlet weak var btnAppleSignIn: UIButton!
    
    @IBOutlet weak var btnGoogleSignIn: UIButton!
    
    @IBOutlet weak var btnForgot: UIButton!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var lbGoogleLogin: UILabel!
    
    // MARK: - Variables
    

    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        loginSuccess()

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
        view.sendSubviewToBack(imgvLoginBackground)
        // 設置mail的圖像
        setupLeftView(imageName: "mail", for: txfMail, width: 20, height: 15)
        
        // 設置password的圖像
        setupLeftView(imageName: "password", for: txfPassword, width: 20, height: 20)

        // 設置每個按鈕的style
        btnForgot.setTitle(NSLocalizedString("Forgot",comment: ""), for: .normal)
        btnRegister.setTitle(NSLocalizedString("Register",comment: ""), for: .normal)
        
        btnSignIn.setTitle(NSLocalizedString("Login",comment: ""), for: .normal)
        
        lbGoogleLogin.text = NSLocalizedString("Google Login", comment: "")
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
    
    func loginSuccess() {
        UserPreferences.shared.isLoggedIn = true
    }
    // MARK: - IBAction
    
    @IBAction func signIn(_ sender: Any) {
//        print(UserPreferences.shared.loginCount)
//
        if txfMail.text != UserPreferences.shared.userMail ||
           txfPassword.text != UserPreferences.shared.userPassword ||
           !isEmailValid(txfMail.text!) ||
           !isPasswordValid(txfPassword.text!) {

        Alert().showAlert(title: NSLocalizedString("Account or Password format error", comment: ""),
                          message: NSLocalizedString("Wrong email\nWrong password\nWrong password format\nInconsistent passwords", comment: ""),
                          vc: self,
                          okActionHandler: nil)
        } else {
            if UserPreferences.shared.loginCount == 0 {
                let privacyBookVC = PrivacyBookViewController()
                navigationController?.pushViewController(privacyBookVC, animated: true)
            } else {
                // go to main VC
                let activityIndicator = UIActivityIndicatorView(style: .large)
                activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                activityIndicator.backgroundColor = .lightGray
                activityIndicator.alpha = 0.5
                activityIndicator.center = view.center
                activityIndicator.layer.cornerRadius = activityIndicator.frame.width / 10
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    activityIndicator.stopAnimating()
                    activityIndicator.hidesWhenStopped = true
                    let mainVC = TabbarViewController()
                    self.navigationController?.pushViewController(mainVC, animated: true)
                }
            }
            UserPreferences.shared.loginCount += 1
        }
//        let mainVC = TabbarViewController()
//        self.navigationController?.pushViewController(mainVC, animated: true)
        
//        let privacyBookVC = TabbarViewController()
//        navigationController?.pushViewController(privacyBookVC, animated: true)
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


