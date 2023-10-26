//
//  BloodSugarConfirmViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/13.
//

import UIKit

class BloodSugarConfirmViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var lbBloodSugar: UILabel!
    
    @IBOutlet weak var lbTime: UILabel!
    
    @IBOutlet weak var btnConfirm: UIButton!
    
    @IBOutlet weak var btnUpdate: UIButton!
    
    
    // MARK: - Variables
    
    var storeBloodSugar: String?
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        updateTime()
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
        btnConfirm.setTitle("確認", for: .normal)
        btnUpdate.setTitle("更正", for: .normal)
        
        lbBloodSugar.text = storeBloodSugar
    }
    
    func setupNavigation() {
        
    }
    // MARK: - IBAction
    
    @IBAction func confirm(_ sender: Any) {
        let tabbarVC = TabbarViewController()
        navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    @IBAction func update(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func updateTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a" // 小时、分钟、上午/下午
        let currentTime = dateFormatter.string(from: Date())
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: Date())
        
        var timeOfDay = ""
        if hour < 12 {
            timeOfDay = "早上"
        } else {
            timeOfDay = "下午"
        }
        
        lbTime.text = currentTime.replacingOccurrences(of: "AM", with: timeOfDay).replacingOccurrences(of: "PM", with: timeOfDay)
    }
    
}
// MARK: - Extension

// MARK: - Protocol


