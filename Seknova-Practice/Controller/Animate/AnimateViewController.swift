//
//  AnimateViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/27.
//

import UIKit
class AnimateViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var imgvAnimate: UIImageView!
    
    // MARK: - Variables
    var images = [UIImage]()
    
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
        self.navigationController?.isNavigationBarHidden = true

        for i in 0...11 {
            images.append(UIImage(named: "connecting_\(i)")!)
        }
        
        let animatedImage = UIImage.animatedImage(with: images, duration: TimeInterval(images.count) * 0.2)
        imgvAnimate.image = animatedImage
        imgvAnimate.animationRepeatCount = 1
        
        // 動畫完成後，跳到下一個視圖控制器
        DispatchQueue.main.asyncAfter(deadline: .now() + animatedImage!.duration) {
            let backVC = PairBlueToothViewController()
            backVC.animated = true
            self.navigationController?.pushViewController(backVC, animated: true)
        }
    }
    
    func setupNavigation() {
        
    }
    
    // MARK: - IBAction
    
}
// MARK: - Extension

// MARK: - Protocol


