//
//  BindPhoneViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/16.
//

import UIKit

class BindPhoneViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bindPhoneLabel: UILabel!
    
    @IBOutlet weak var inputPhoneView: UIView!
    
    @IBOutlet weak var inputPhoneNumber: UITextField!
    
    @IBOutlet weak var getVerificationBTN: UIButton!
    
    
    @IBOutlet weak var inputVerificationView: UIView!
    
    @IBOutlet weak var inputVerificationBTN: UIButton!
    
    @IBOutlet weak var backBTN: UIButton!
    
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
        
        getVerificationBTN.setTitle("獲得驗證碼", for: .normal)
        inputVerificationBTN.setTitle("輸入驗證碼", for: .normal)
        backBTN.setTitle("返回", for: .normal)
        
        setupViewShadow(for: inputPhoneView)
        setupViewShadow(for: inputVerificationView)
        
        inputPhoneNumber.delegate = self
    }
    
    // MARK: - IBAction
    
    func setupViewShadow(for view: UIView) {
        view.layer.shadowColor = UIColor.gray.cgColor // 設置陰影顏色
        view.layer.shadowOffset = CGSize(width: 0, height: 2) // 設置陰影偏移
        view.layer.shadowRadius = 4.0 // 設置陰影半徑
        view.layer.shadowOpacity = 0.9 // 設置陰影透明度
    }
}
// MARK: - Extension

extension BindPhoneViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let length = string.lengthOfBytes(using: String.Encoding.utf8)
        for loopIndex in 0 ..< length {
            let char = (string as NSString).character(at: loopIndex)
            if char < 48 { return false }
            if char > 57 { return false }
        }
        return true

    }
}
// MARK: - Protocol


