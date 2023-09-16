//
//  ResendCertificationViewController.swift
//  Seknova-Practice
//
//  Created by imac-1682 on 2023/9/13.
//

import UIKit

class ResendCertificationViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ActivatedLabel: UILabel!
    
    @IBOutlet weak var resendBTN: UIButton!
    
    @IBOutlet weak var nextBTN: UIButton!
    
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
        ActivatedLabel.textColor = UIColor(red: 194.0 / 255.0,
                                                green: 15.0 / 255.0,
                                                blue: 36.0 / 255.0, alpha: 1.0)
        
        setupButtonStyle(for: resendBTN, title: "重送認證信")
        setupButtonStyle(for: nextBTN, title: "下一步")
    }
    
    func setupButtonStyle(for button: UIButton, title: String) {
        
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.borderWidth = 5.0
        button.layer.borderColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0).cgColor
        button.setTitle(title, for: .normal)
        button.tintColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
    }
    
    // MARK: - IBAction
    @IBAction func jumpToLogin(_ sender: Any) {
        if let loginVC = self.navigationController?.viewControllers.first(where: { $0 is LoginViewController }) as? LoginViewController {
            loginVC.mail.text = UserDefaults.standard.string(forKey: "mail")
            loginVC.password.text = UserDefaults.standard.string(forKey: "password")
        }
        self.navigationController?.popToRootViewController(animated: true)

    }
}
// MARK: - Extension

// MARK: - Protocol


