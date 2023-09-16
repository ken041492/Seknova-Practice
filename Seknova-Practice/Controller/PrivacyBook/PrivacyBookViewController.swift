//
//  PrivacyBookViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/14.
//

import UIKit

class PrivacyBookViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var approveBTN: UIButton!
    
    // MARK: - Variables
    
    var agreen: Bool = false
    
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
        textView.isEditable = false
        textView.isSelectable = false
        
        approveBTN.layer.cornerRadius = approveBTN.frame.height / 2
        approveBTN.layer.borderWidth = 5.0
        approveBTN.layer.borderColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0).cgColor
        approveBTN.setTitle("確認", for: .normal)
        approveBTN.tintColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
    }
    
    
    // MARK: - IBAction

    @IBAction func accept(_ sender: Any) {
        agreen = true
        let persionalDataVC = PersionalDataViewController()

        navigationController?.pushViewController(persionalDataVC, animated: true)
    }
    
}
// MARK: - Extension

// MARK: - Protocol


