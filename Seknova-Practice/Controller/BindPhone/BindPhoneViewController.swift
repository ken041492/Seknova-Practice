//
//  BindPhoneViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/16.
//

import UIKit

import RealmSwift

class BindPhoneViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbBindPhone: UILabel!
    
    @IBOutlet weak var vInputPhone: UIView!
    
    @IBOutlet weak var txfPhoneNumber: UITextField!
    
    @IBOutlet weak var txfCertification: UITextField!
    
    @IBOutlet weak var btnGetVerification: UIButton!
    
    @IBOutlet weak var vInputVerification: UIView!
    
    @IBOutlet weak var btnInputVerification: UIButton!
    
    @IBOutlet weak var btnBack: UIButton!
    
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
        
        lbBindPhone.text = NSLocalizedString("Bind Phone Cell", comment: "")
        btnGetVerification.setTitle(NSLocalizedString("Get verify code", comment: ""), for: .normal)
        btnInputVerification.setTitle(NSLocalizedString("Input verify code", comment: ""), for: .normal)
        btnBack.setTitle(NSLocalizedString("Return", comment: ""), for: .normal)
        txfCertification.placeholder = NSLocalizedString("Click to edit", comment: "")
        txfPhoneNumber.placeholder = NSLocalizedString("Click to edit", comment: "")
        
        setupViewShadow(for: vInputPhone)
        setupViewShadow(for: vInputVerification)
        
        txfPhoneNumber.delegate = self
    }
    
    func setupViewShadow(for view: UIView) {
        view.layer.shadowColor = UIColor.gray.cgColor // 設置陰影顏色
        view.layer.shadowOffset = CGSize(width: 0, height: 2) // 設置陰影偏移
        view.layer.shadowRadius = 4.0 // 設置陰影半徑
        view.layer.shadowOpacity = 0.9 // 設置陰影透明度
    }
    // MARK: - IBAction
    
    @IBAction func backToMain(_ sender: Any) {
        let realm = try! Realm()
        let infoData = realm.objects(UserInformation.self)
        if infoData[0].Phone == txfPhoneNumber.text {
            infoData[0].Phone_Verified = true
            navigationController?.popViewController(animated: true)
        } else {
            Alert().showAlert(title: "錯誤", message: "請輸入正確的手機號碼", vc: self)
        }
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


