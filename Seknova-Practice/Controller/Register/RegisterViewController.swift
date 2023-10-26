//
//  RegisterViewController.swift
//  Seknova-Practice
//
//  Created by imac-1682 on 2023/9/12.
//

import UIKit

import RealmSwift

class RegisterViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var imgvRegisterBackground: UIImageView!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbRegisterAcount: UILabel!
    
    @IBOutlet weak var txfMail: UITextField!
    
    @IBOutlet weak var txfPassword: UITextField!
    
    @IBOutlet weak var txfAgainPassword: UITextField!
    
    @IBOutlet weak var btnCountry: UIButton!

    @IBOutlet weak var btnCheck: UIButton!
    
    @IBOutlet weak var btnCheckCenter: UIButton!
    
    @IBOutlet weak var btnPrivacyBook: UIButton!
    
    @IBOutlet weak var pkvArea: UIPickerView!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var vBackground: UIView!
    
    // MARK: - Variables
    
    let country: [String] = ["Taiwan(台灣)", "America(美國)"]
    var judge: Bool = true
    var firstJudge: Bool = false
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
        view.sendSubviewToBack(imgvRegisterBackground)
        pkvArea.delegate = self
        pkvArea.dataSource = self
        
        setupLeftView(imageName: "mail", for: txfMail, width: 45, height: 20)
        setupLeftView(imageName: "password", for: txfPassword, width: 45, height: 30)
        setupLeftView(imageName: "password", for: txfAgainPassword, width: 45, height: 30)
        // checkBTN
        btnCheck.layer.cornerRadius = btnCheck.frame.width / 2 // 使按钮呈圆形
        btnCheck.backgroundColor = UIColor.white
        btnCheckCenter.layer.cornerRadius = btnCheckCenter.frame.width / 2
        btnCheckCenter.backgroundColor = UIColor.white
        
        
        btnRegister.setTitle("註冊", for: .normal)
        // 增加陰影
        vBackground.layer.shadowColor = UIColor.gray.cgColor // 設置陰影顏色
        vBackground.layer.shadowOffset = CGSize(width: 0, height: 2) // 設置陰影偏移
        vBackground.layer.shadowRadius = 4.0 // 設置陰影半徑
        vBackground.layer.shadowOpacity = 0.9 // 設置陰影透明度
        
        pkvArea.isHidden = true
        btnCheckCenter.backgroundColor = UIColor.white
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
        pkvArea.isHidden = false
        btnRegister.isHidden = true
        btnRegister.backgroundColor = UIColor.white
    }
    
    @IBAction func judgeCheck(_ sender: UIButton) {
        print(judge)
        if sender == btnCheck || sender == btnCheckCenter {
            if firstJudge == false {
                Alert().showAlert(title: "錯誤",
                                  message: "未點擊條件與條款",
                                  vc: self,
                                  okActionHandler: nil)
            } else {
                if judge {
                    btnCheckCenter.backgroundColor = UIColor.gray
                } else {
                    btnCheckCenter.backgroundColor = UIColor.white
                }
                judge.toggle()
            }
        }
    }
    
    
    @IBAction func popPrivacyBook(_ sender: Any) {
        // 創建彈出視圖控制器
        let popoverVC = PrivacyBookViewController()
        popoverVC.delegate = self
        popoverVC.agreen = true
        popoverVC.view.backgroundColor = UIColor.white
        popoverVC.preferredContentSize = CGSize(width: view.frame.width * 9 / 10, height: view.frame.height * 9 / 10)
        // 以彈出視窗的形式顯示在目前視圖控制器上
        popoverVC.modalPresentationStyle = .popover
        let popoverPresentationController = popoverVC.popoverPresentationController
        // 從當前view 彈出 並對齊navigationBar
        popoverPresentationController!.sourceView = self.view
            popoverPresentationController!.sourceRect = CGRect(
                x: 0,
                y: (self.navigationController?.navigationBar.frame.maxY)!,
                width: self.view.bounds.width,
                height: 1
            )
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.delegate = self
        // 显示弹出视图
        present(popoverVC, animated: true, completion: nil)
    }
    
    @IBAction func jumpToResendCertification(_ sender: Any) {
        if txfMail.text == "" || txfPassword.text == "" || txfAgainPassword.text == ""
            || !isEmailValid(inputEmail) || !isPasswordValid(inputPassword)
            || judge || (inputPassword != inputAgainPw){
            
            Alert().showAlert(title: "帳號密碼或更改格式錯誤",
                              message: "電子信箱錯誤\n密碼錯誤\n密碼格式錯誤\n密碼不一致",
                              vc: self,
                              okActionHandler: nil)
        } else {
            // 一致就跳轉到重送驗證信頁面
            UserPreferences.shared.userMail = inputEmail
//            let realm = try! Realm()
//            let infoData = realm.objects(UserInformation.self)
//            try! realm.write {
//                infoData[0].Email = inputEmail
//            }
            UserPreferences.shared.userPassword = inputPassword
            UserPreferences.shared.loginCount = 0
                            
            let resendCertification = ResendCertificationViewController()
            navigationController?.pushViewController(resendCertification, animated: true)
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
        btnCountry.setTitle(country[row], for: .normal)
        pkvArea.isHidden = true
        btnRegister.isHidden = false
    }
}

extension RegisterViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension RegisterViewController: ChangeBTNColor {
    func changeButtonColor() {
//        checkBTN.backgroundColor = UIColor.blue
//        checkCenterBTN.isHidden = false
        btnCheckCenter.backgroundColor = UIColor.gray
        judge = false
        firstJudge = true
    }
}
// MARK: - Protocol

protocol ChangeBTNColor {
    func changeButtonColor()
}

