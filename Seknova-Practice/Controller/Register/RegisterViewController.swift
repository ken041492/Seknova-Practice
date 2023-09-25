//
//  RegisterViewController.swift
//  Seknova-Practice
//
//  Created by imac-1682 on 2023/9/12.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var registerBackground: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var registerAcountLabel: UILabel!
    
    @IBOutlet weak var mail: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var againPassword: UITextField!
    
    @IBOutlet weak var countryBTN: UIButton!

    @IBOutlet weak var checkBTN: UIButton!
    
    @IBOutlet weak var privacyBook: UIButton!
    
    @IBOutlet weak var areaPickerView: UIPickerView!
    
    @IBOutlet weak var registerBTN: UIButton!
    
    @IBOutlet weak var backgroundView: UIView!
    
    // MARK: - Variables
    let country: [String] = ["Taiwan(台灣)", "America(美國)"]
    var judge: Bool = true
    var selectCountry: String = ""
    var inputEmail: String = ""
    var inputPassword: String = ""
    var inputAgainPw: String = ""
    
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
        view.sendSubviewToBack(registerBackground)
        areaPickerView.delegate = self
        areaPickerView.dataSource = self
        
        setupLeftView(imageName: "mail", for: mail, width: 45, height: 20)
        setupLeftView(imageName: "password", for: password, width: 45, height: 30)
        setupLeftView(imageName: "password", for: againPassword, width: 45, height: 30)
        // checkBTN
        checkBTN.layer.cornerRadius = checkBTN.frame.width / 2 // 使按钮呈圆形
        checkBTN.backgroundColor = UIColor.white
        
        registerBTN.setTitle("註冊", for: .normal)
        // 增加陰影
        backgroundView.layer.shadowColor = UIColor.gray.cgColor // 設置陰影顏色
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 2) // 設置陰影偏移
        backgroundView.layer.shadowRadius = 4.0 // 設置陰影半徑
        backgroundView.layer.shadowOpacity = 0.9 // 設置陰影透明度
        
        areaPickerView.isHidden = true
    }
    
    @objc func buttonTapped() {
        // 处理按钮点击事件
        print("按钮被点击了！")
    }
    func setupNavigation() {
        navigationItem.title = "Register"
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupLeftView(imageName: String, for textField: UITextField, width: CGFloat, height: CGFloat) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 25, height: height))
        imageView.image = UIImage(named: imageName)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        leftView.addSubview(imageView)
        
        textField.leftView = leftView
        textField.leftViewMode = .always
    }

    // MARK: - IBAction
    @objc func add_BTN() {
        print(1234)
    }
    
    @IBAction func showPickerView(_ sender: Any) {
        areaPickerView.isHidden = false
        registerBTN.isHidden = true
    }
    
    
    @IBAction func judgeCheck(_ sender: Any) {
        print(judge)
        if judge {
            
            checkBTN.backgroundColor = UIColor.blue
        } else {
            checkBTN.backgroundColor = UIColor.white
        }
        judge.toggle()
    }
    
    
    @IBAction func popPrivacyBook(_ sender: Any) {
        
        // 創建彈出視圖控制器
        let popoverVC = PrivacyBookViewController()
        popoverVC.delegate = self
        popoverVC.agreen = true
        popoverVC.view.backgroundColor = UIColor.white
        popoverVC.preferredContentSize = CGSize(width: view.frame.width * 9 / 10, height: view.frame.height * 9 / 10)

        // 設置彈出視圖控制器的樣式和位置
        
        // 以彈出視窗的形式顯示在目前視圖控制器上
        popoverVC.modalPresentationStyle = .popover
        let popoverPresentationController = popoverVC.popoverPresentationController
        // 從當前view 彈出
        popoverPresentationController?.sourceView = view
        popoverPresentationController?.sourceRect = CGRect(x: view.frame.width / 2,
                                                           y: view.frame.height / 9, width: 1, height: 1)
        popoverPresentationController?.permittedArrowDirections = .any
        popoverPresentationController?.delegate = self

        // 显示弹出视图
        present(popoverVC, animated: true, completion: nil)
    }
    
    @IBAction func jumpToResendCertification(_ sender: Any) {
        if mail.text == "" || password.text == "" || againPassword.text == ""
            || !isEmailValid(inputEmail) || !isPasswordValid(inputPassword)
            || judge {
            
            let controller = UIAlertController(title: "錯誤",
                                               message: "信箱或密碼格式錯誤或未點擊條件與條款",
                                               preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true)
        
        } else {
            // 一致就跳轉到重送驗證信頁面
            if (inputPassword == inputAgainPw) {
                UserDefaults.standard.set(inputEmail, forKey: "mail")
                UserDefaults.standard.set(inputPassword, forKey: "password")
                UserDefaults.standard.set(0, forKey: "loginCount")

                print("test \(type(of: UserDefaults.standard.string(forKey: "loginCount")!))")
                
                let resendCertification = ResendCertificationViewController()
                navigationController?.pushViewController(resendCertification, animated: true)
            } else {
                let controller = UIAlertController(title: "密碼有誤!",
                                                   message: "輸入的密碼不一致",
                                                   preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                controller.addAction(okAction)
                present(controller, animated: true)
                
                password.text = ""
                againPassword.text = ""
            }
        }
    }
    
    @IBAction func mailText(_ sender: UITextField) {
        inputEmail = sender.text!
    }
    
    @IBAction func passwordText(_ sender: UITextField) {
        inputPassword = sender.text!
    }
    
    @IBAction func againPwText(_ sender: UITextField) {
        inputAgainPw = sender.text!
    }
    
    func isPasswordValid(_ text: String) -> Bool {
//        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8}$"
//        let passwordRegex = "^(?=.*\\d{8,}).*[A-Za-z].*[A-Za-z].*$"
//        let passwordRegex = "^(?=.*\\d{8,})(?=.*[A-Za-z])(?=.*[A-Za-z]).*$"
        // ^ 開始 $ 結束
        // (?=.*[a-z]) 至少有一個a-z
        // (?=.*[A-Z]) 至少有一個A-Z
        // (?=.*\\d) 至少有一個數字
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
extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return country.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
      titleForRow row: Int, forComponent component: Int)
    -> String? {
        return country[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryBTN.setTitle(country[row], for: .normal)
        areaPickerView.isHidden = true
        registerBTN.isHidden = false
    }
}

extension RegisterViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
extension RegisterViewController: ChangeBTNColor {
    func changeButtonColor() {
        checkBTN.backgroundColor = UIColor.blue
        judge = false
    }
}
// MARK: - Protocol

protocol ChangeBTNColor {
    func changeButtonColor()
}

