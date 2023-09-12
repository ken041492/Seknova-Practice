//
//  ForgotPasswordViewController.swift
//  Seknova-Practice
//
//  Created by imac-1682 on 2023/9/12.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var forgotPwBackground: UIImageView!
    
    @IBOutlet weak var sendBTN: UIButton!
    
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
        view.sendSubviewToBack(forgotPwBackground)

        sendBTN.layer.cornerRadius = sendBTN.frame.height / 2
        // 設定 forgotPassword BTN
        sendBTN.layer.borderWidth = 5.0 // 设置边框宽度
        sendBTN.layer.borderColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                              blue: 36.0 / 255.0, alpha: 1.0).cgColor
        sendBTN.setTitle("送出", for: .normal)
        sendBTN.tintColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                      blue: 36.0 / 255.0, alpha: 1.0)
    }
    
    func setupNavigation() {
        title = "FORGOT PASSWORD"
//        let barAppearance = UINavigationBarAppearance()
//        barAppearance.backgroundColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
//                                                blue: 36.0 / 255.0, alpha: 1.0)
//        barAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        // 應用於導航欄的標準狀態
//        navigationController?.navigationBar.standardAppearance = barAppearance
//        // 應用於導航欄的滾動邊緣狀態
//        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance

    }
    
    // MARK: - IBAction
    @IBAction func jumpToResetPwVC(_ sender: Any) {
        let resetPwVC = ResetPasswordViewController()
        let backButton = UIBarButtonItem()
        navigationItem.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(resetPwVC, animated: true)
    }
    
}
// MARK: - Extension

// MARK: - Protocol


