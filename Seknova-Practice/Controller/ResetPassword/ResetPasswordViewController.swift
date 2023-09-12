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
    
    // MARK: - Variables
    
    
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
        // 設置oldPassword的圖像
        let oldPasswordImage = UIImageView(frame: CGRect(x: 10, y: 0,
                                                      width: 25, height: 30))
        oldPasswordImage.image = UIImage(named: "password") // 設置小圖片的圖像
        let oldPasswordLeftView = UIView(frame: CGRect(x: 0, y: 0,
                                                    width: 35, height: 30))
        oldPasswordLeftView.addSubview(oldPasswordImage)
        oldPassword.leftView = oldPasswordLeftView
        oldPassword.leftViewMode = .always
        
        oldPassword.layer.shadowColor = UIColor.gray.cgColor // 设置阴影颜色
        oldPassword.layer.shadowOffset = CGSize(width: 0, height: 2) // 设置阴影偏移
        oldPassword.layer.shadowRadius = 4.0 // 设置阴影半径
        oldPassword.layer.shadowOpacity = 0.5 // 设置阴影透明度
        
        // 設置newPassword的圖像
        let newPasswordImage = UIImageView(frame: CGRect(x: 10, y: 0,
                                                      width: 25, height: 30))
        newPasswordImage.image = UIImage(named: "password") // 設置小圖片的圖像
        let newPasswordLeftView = UIView(frame: CGRect(x: 0, y: 0,
                                                    width: 35, height: 30))
        newPasswordLeftView.addSubview(newPasswordImage)
        newPassword.leftView = newPasswordLeftView
        newPassword.leftViewMode = .always
        
        newPassword.layer.shadowColor = UIColor.gray.cgColor // 设置阴影颜色
        newPassword.layer.shadowOffset = CGSize(width: 0, height: 2) // 设置阴影偏移
        newPassword.layer.shadowRadius = 4.0 // 设置阴影半径
        newPassword.layer.shadowOpacity = 0.5 // 设置阴影透明度
        
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
        
        // 設定 送出按鈕
        sendBTN.layer.cornerRadius = sendBTN.frame.height / 2
        sendBTN.layer.borderWidth = 5.0 // 设置边框宽度
        sendBTN.layer.borderColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                              blue: 36.0 / 255.0, alpha: 1.0).cgColor
        sendBTN.setTitle("忘記密碼", for: .normal)
        sendBTN.tintColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                      blue: 36.0 / 255.0, alpha: 1.0)
    }
    
    // MARK: - IBAction
    
}
// MARK: - Extension

// MARK: - Protocol


