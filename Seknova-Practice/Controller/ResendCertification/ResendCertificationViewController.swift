//
//  ResendCertificationViewController.swift
//  Seknova-Practice
//
//  Created by imac-1682 on 2023/9/13.
//

import UIKit

class ResendCertificationViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbActivated: UILabel!
    
    @IBOutlet weak var btnResend: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!
    
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
        btnResend.setTitle("重送認證信", for: .normal)
        btnNext.setTitle("下一步", for: .normal)
    }
    
    // MARK: - IBAction
    @IBAction func jumpToLogin(_ sender: Any) {
        if let loginVC = self.navigationController?.viewControllers.first(where: { $0 is LoginViewController }) as? LoginViewController {
            loginVC.txfMail.text = UserPreferences.shared.userMail
            loginVC.txfPassword.text = UserPreferences.shared.userPassword
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}
// MARK: - Extension

// MARK: - Protocol


