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
    
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var againPassword: UITextField!
    
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
        view.sendSubviewToBack(registerBackground)
        
        // 調整mail的圖像大小
        let mailImage = UIImageView(frame: CGRect(x: 10, y: 0,
                                                  width: 25, height: 20))
        mailImage.image = UIImage(named: "mail")
        // 調整圖像佔textField的大小
        let mailLeftView = UIView(frame: CGRect(x: 0, y: 0,
                                                width: 35, height: 20))
        mailLeftView.addSubview(mailImage)
        mail.leftView = mailLeftView
        mail.leftViewMode = .always
        // 增加陰影
        mail.layer.shadowColor = UIColor.gray.cgColor // 設置陰影顏色
        mail.layer.shadowOffset = CGSize(width: 0, height: 2) // 設置陰影偏移
        mail.layer.shadowRadius = 4.0 // 設置陰影半徑
        mail.layer.shadowOpacity = 0.5 // 設置陰影透明度
        // 設置password的圖像
        let passwordImage = UIImageView(frame: CGRect(x: 10, y: 0,
                                                      width: 25, height: 30))
        passwordImage.image = UIImage(named: "password") // 設置小圖片的圖像
        let passwordLeftView = UIView(frame: CGRect(x: 0, y: 0,
                                                    width: 35, height: 30))
        passwordLeftView.addSubview(passwordImage)
        password.leftView = passwordLeftView
        password.leftViewMode = .always
        
        password.layer.shadowColor = UIColor.gray.cgColor // 设置阴影颜色
        password.layer.shadowOffset = CGSize(width: 0, height: 2) // 设置阴影偏移
        password.layer.shadowRadius = 4.0 // 设置阴影半径
        password.layer.shadowOpacity = 0.5 // 设置阴影透明度
        
        // 設置againPassword的圖像
        let againPasswordImage = UIImageView(frame: CGRect(x: 10, y: 0,
                                                      width: 25, height: 30))
        againPasswordImage.image = UIImage(named: "password") // 設置小圖片的圖像
        let againPasswordLeftView = UIView(frame: CGRect(x: 0, y: 0,
                                                    width: 35, height: 30))
        againPasswordLeftView.addSubview(againPasswordImage)
        againPassword.leftView = againPasswordLeftView
        againPassword.leftViewMode = .always
        
        againPassword.layer.shadowColor = UIColor.gray.cgColor // 设置阴影颜色
        againPassword.layer.shadowOffset = CGSize(width: 0, height: 2) // 设置阴影偏移
        againPassword.layer.shadowRadius = 4.0 // 设置阴影半径
        againPassword.layer.shadowOpacity = 0.5 // 设置阴影透明度
        
        // 設置 註冊按鈕
        registerBTN.layer.cornerRadius = registerBTN.frame.height / 2
        registerBTN.layer.borderWidth = 5.0 // 设置边框宽度
        registerBTN.layer.borderColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                              blue: 36.0 / 255.0, alpha: 1.0).cgColor
        registerBTN.setTitle("註冊", for: .normal)
        registerBTN.tintColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                      blue: 36.0 / 255.0, alpha: 1.0)
    }
    
    func setupNavigation() {
        title = "Register"
//        let barAppearance = UINavigationBarAppearance()
//        barAppearance.backgroundColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
//                                                blue: 36.0 / 255.0, alpha: 1.0)
//        barAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//
//        // 應用於導航欄的標準狀態
//        navigationController?.navigationBar.standardAppearance = barAppearance
//        // 應用於導航欄的滾動邊緣狀態
//        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance

    }
    
    // MARK: - IBAction
    @objc func add_BTN() {
        print(1234)
    }
}
// MARK: - Extension

// MARK: - Protocol


