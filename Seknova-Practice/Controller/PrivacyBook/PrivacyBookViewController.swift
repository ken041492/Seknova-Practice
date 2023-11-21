//
//  PrivacyBookViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/14.
//

import UIKit

class PrivacyBookViewController: UIViewController {
    
    // MARK: - IBOutlet
            
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbText: UILabel!
    
    @IBOutlet weak var btnApprove: UIButton!
    
    // MARK: - Variables
    
    var agreen: Bool = false
    var delegate: ChangeBTNColor?

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
        delegate?.changeButtonColor()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        lbTitle.text = NSLocalizedString("Seknova App Terms of Use", comment: "")
        lbText.text = NSLocalizedString("SeknovaAppTermsOfUse", comment: "")
        btnApprove.setTitle(NSLocalizedString("Confirm", comment: ""), for: .normal)
    }
    
    // MARK: - IBAction

    @IBAction func accept(_ sender: Any) {
        if agreen {
            dismiss(animated: false)
        } else {
            let persionalDataVC = PersionalDataViewController()
            navigationController?.pushViewController(persionalDataVC, animated: true)
        }
    }
}
// MARK: - Extension

// MARK: - Protocol


