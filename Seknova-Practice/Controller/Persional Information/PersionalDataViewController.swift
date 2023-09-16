//
//  PersionalDataViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/16.
//

import UIKit

class PersionalDataViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var nextBTN: UIButton!
    
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
        backgroundView.backgroundColor = UIColor(red: 223.0 / 255.0, green: 224.0 / 255.0,
                                                 blue: 227.0 / 255.0, alpha: 1.0)
        
        nextBTN.layer.cornerRadius = nextBTN.frame.height / 2
        nextBTN.layer.borderWidth = 5.0 // 设置边框宽度
        nextBTN.layer.borderColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                              blue: 36.0 / 255.0, alpha: 1.0).cgColor
        nextBTN.setTitle("下一步", for: .normal)
        nextBTN.tintColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                      blue: 36.0 / 255.0, alpha: 1.0)
    }
    
    func setupNavigation() {
        title = "Persional Information"
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.backBarButtonItem = nil
    }
    
    // MARK: - IBAction
    
    
}
// MARK: - Extension

// MARK: - Protocol



