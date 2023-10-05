//
//  TabbarViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/2.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    // MARK: - IBOutlet

    
    // MARK: - Variables
    
    var setTitle: String = ""
    let bottomLineView = UIView()
    
    // MARK: - LifeCycle
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        
        setupTabs()
        setFont()
        
        title = "即時血糖"
        delegate = self
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.backBarButtonItem = nil
        
        
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        
    }
    
    func setupNavigation() {
        let imageSize = CGSize(width: 25, height: 25) // 指定所需的圖片大小

        let imgLink = resizeImage(image: UIImage(named: "link")!.withRenderingMode(.alwaysOriginal),
                                  targetSize: imageSize)

        let imgThreeLine = resizeImage(image: UIImage(named: "ThreeLineSmall")!.withRenderingMode(.alwaysOriginal),
                                       targetSize: imageSize)
        
        let btnThreeLine = UIButton(type: .custom)
            btnThreeLine.setImage(imgThreeLine, for: .normal)
            btnThreeLine.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
            btnThreeLine.addTarget(self,
                                   action: #selector(button1Tapped),
                                   for: .touchUpInside)
        
        let btnLink = UIButton(type: .custom)
        btnLink.setImage(imgLink, for: .normal)
        btnLink.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        btnLink.addTarget(self,
                          action: #selector(button2Tapped),
                          for: .touchUpInside)
        
        let leftButtonItem1 = UIBarButtonItem(customView: btnThreeLine)
        let leftButtonItem2 = UIBarButtonItem(customView: btnLink)
        
        navigationItem.leftBarButtonItems = [leftButtonItem1, leftButtonItem2]
    }
    
    
    
    private func setupTabs() {
        
        // 指定所需的圖片大小
        let imageSize = CGSize(width: 28, height: 28)
        
        // 創建圖片，並調整大小
        let historyImage = resizeImage(image: UIImage(named: "history")!,
                                       targetSize: imageSize)
        
        let bloodImage = resizeImage(image: UIImage(named: "blood-1")!,
                                     targetSize: imageSize)
    
        let trendImage = resizeImage(image: UIImage(named: "trend")!,
                                     targetSize: imageSize)
    
        let calendarImage = resizeImage(image: UIImage(named: "calendar-1")!,
                                        targetSize: imageSize)
    
        let userImage = resizeImage(image: UIImage(named: "user")!,
                                    targetSize: imageSize)
        
        // 創建每個Tab的ViewController
        let histroyVC = createNav(whit: "歷史紀錄",
                                  and: historyImage,
                                  vc: HistoryViewController())
    
        let bloodSugarCorrectVC = createNav(whit: "血糖校正",
                                            and: bloodImage,
                                            vc: BloodCorrectViewController())
    
        let immediateBloodSugarVC = createNav(whit: "即時血糖",
                                              and: trendImage,
                                              vc: BloodImmediateViewController())
    
        let lifeStyleVC = createNav(whit: "生活作息",
                                    and: calendarImage,
                                    vc: LifeStyleViewController())
    
        let personalVC = createNav(whit: "個人資訊",
                                   and: userImage,
                                   vc: PersonalViewController())
        
        histroyVC.tabBarItem.imageInsets = UIEdgeInsets(top: -10,
                                                        left: 0,
                                                        bottom: -4,
                                                        right: 0)
        
        bloodSugarCorrectVC.tabBarItem.imageInsets = UIEdgeInsets(top: -10,
                                                                  left: 0,
                                                                  bottom: -4,
                                                                  right: 0)
        
        immediateBloodSugarVC.tabBarItem.imageInsets = UIEdgeInsets(top: -10,
                                                                    left: 0,
                                                                    bottom: -4,
                                                                    right: 0)
        
        lifeStyleVC.tabBarItem.imageInsets = UIEdgeInsets(top: -10,
                                                          left: 0,
                                                          bottom: -4,
                                                          right: 0)
        
        personalVC.tabBarItem.imageInsets = UIEdgeInsets(top: -10,
                                                         left: 0,
                                                         bottom: -4,
                                                         right: 0)
        
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.tintColor = .black
        
        self.setViewControllers([histroyVC, bloodSugarCorrectVC, immediateBloodSugarVC, lifeStyleVC, personalVC], animated: true)
        selectedIndex = 2
    }
    
    private func createNav(whit title: String,
                           and image: UIImage?,
                           vc:UIViewController) -> UINavigationController {
        
        let NavigationController = UINavigationController(rootViewController: vc)
        NavigationController.tabBarItem.title = title
        NavigationController.tabBarItem.image = image
        return NavigationController
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // 確定保持原始圖片的寬高比例，並根據較小的比例來縮放圖片
        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        // 根據目標大小和新尺寸縮放圖片
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    private func setFont() {
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18.0), // 設置所需的文字大小
            .foregroundColor: UIColor.black // 設置所需的文字顏色
        ]

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18.0), // 設置所需的文字大小
            .foregroundColor: UIColor.black // 設置所需的文字顏色
        ]
        // 將文字屬性應用於UITabBarItem
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
    }
    
    // MARK: - IBAction
    
    @objc func button1Tapped() {
        // 处理按钮1的点击事件
        print("hello")
    }

    @objc func button2Tapped() {
        // 处理按钮2的点击事件
        print("hello2")

    }
    
    @objc func backButtonTapped() {
        // 处理返回按钮的点击事件
        print(1234567)
    }
}
// MARK: - Extension

extension TabbarViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {

        if viewController == viewControllers?[0] {
            title = "歷史紀錄"
            print("first page")
        }
        if viewController == viewControllers?[1] {
            title = "血糖校正"
            print("second page")
        }
        if viewController == viewControllers?[2] {
            title = "即時血糖"
            print("third page")
        }
        if viewController == viewControllers?[3] {
            title = "生活作息"
            print("fouth page")
        }
        if viewController == viewControllers?[4] {
            title = "個人資訊"
            print("last page")
        }
    }
}

// MARK: - Protocol


