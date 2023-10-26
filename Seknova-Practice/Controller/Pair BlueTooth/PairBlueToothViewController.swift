//
//  PairBlueToothViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/24.
//

import UIKit

class PairBlueToothViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbContent: UILabel!
    
    @IBOutlet weak var imgvBlueTooth: UIImageView!
    
    @IBOutlet weak var imgvPhone: UIImageView!
    
    @IBOutlet weak var imgvDot: UIImageView!
    
    @IBOutlet weak var imgvDevice: UIImageView!
    
    @IBOutlet weak var imgvCorrect: UIImageView!
    
    @IBOutlet weak var btnPair: UIButton!
    
    @IBOutlet weak var btnCancle: UIButton!
    
    // MARK: - Variables
    
    var animated: Bool = false
    
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
        navigationController?.isNavigationBarHidden = false
        if !animated {
            imgvCorrect.isHidden = true
            btnPair.setTitle("配對", for: .normal)
            btnCancle.setTitle("取消", for: .normal)
        } else {
            lbTitle.isHidden = true
            lbContent.isHidden = true
            imgvBlueTooth.isHidden = true
            imgvPhone.isHidden = true
            imgvDot.isHidden = true
            imgvDevice.isHidden = true
            btnPair.isHidden = true
            btnCancle.isHidden = true
            
            imgvCorrect.isHidden = false
            UserPreferences.shared.isPair = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                let scanSensorVC = ScannigSensorViewController()
                self.navigationController?.pushViewController(scanSensorVC,
                                                              animated: true)
            }
        }
    }
    
    func setupNavigation() {
        title = "Pair Bluetooth"
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.backBarButtonItem = nil
    }
    
    // MARK: - IBAction
    
    @IBAction func pair(_ sender: Any) {
        let animateVC = AnimateViewController()
        navigationController?.pushViewController(animateVC, animated: true)
    }
    
    @IBAction func cancle(_ sender: Any) {
        UserPreferences.shared.deviceID = ""
        let backVC = TransmitterViewController()
        backVC.didProcessQRCode = false
        navigationController?.popViewController(animated: true)
    }
    
    
}
// MARK: - Extension

// MARK: - Protocol


