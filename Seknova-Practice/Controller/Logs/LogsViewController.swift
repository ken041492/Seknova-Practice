//
//  LogsViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/16.
//

import UIKit

class LogsViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    
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
        
    }
    
    func setupNavigation() {
        title = "Logs"
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let rightButton = UIBarButtonItem()
        rightButton.title = "All"
        navigationItem.rightBarButtonItem = rightButton
    }
    
    // MARK: - IBAction
    
}
// MARK: - Extension

// MARK: - Protocol


