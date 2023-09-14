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
        
        titleLabel.textColor = UIColor(red: 194.0 / 255.0,
                                       green: 15.0 / 255.0,
                                       blue: 36.0 / 255.0, alpha: 1.0)
        resetPwLabel.textColor = UIColor(red: 194.0 / 255.0,
                                                green: 15.0 / 255.0,
                                                blue: 36.0 / 255.0, alpha: 1.0)
        
        // 設置mail的圖像
        setupLeftView(imageName: "mail", for: mail, width: 25, height: 20)
        // 設置password的圖像
        setupLeftView(imageName: "password", for: oldPassword, width: 25, height: 30)
        setupLeftView(imageName: "password", for: newPassword, width: 25, height: 30)
        setupLeftView(imageName: "password", for: againPassword, width: 25, height: 30)
        
        // 設定 送出按鈕
        sendBTN.layer.cornerRadius = sendBTN.frame.height / 2
        sendBTN.layer.borderWidth = 5.0 // 设置边框宽度
        sendBTN.layer.borderColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                              blue: 36.0 / 255.0, alpha: 1.0).cgColor
        sendBTN.setTitle("送出", for: .normal)
        sendBTN.tintColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                      blue: 36.0 / 255.0, alpha: 1.0)
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
    
}
// MARK: - Extension

// MARK: - Protocol


