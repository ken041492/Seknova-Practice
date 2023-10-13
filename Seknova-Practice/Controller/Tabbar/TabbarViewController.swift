//
//  TabbarViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/2.
//

import UIKit

class TabbarViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var customTabBar: CustomTabBar!
    
    @IBOutlet weak var vMenu: UIView!
    
    // MARK: - Variables
    
    private var histroyVC = HistoryViewController()
    
    private var bloodSugarCorrectVC = BloodCorrectViewController()
    
    private var immediateBloodSugarVC = BloodImmediateViewController()
    
    private var lifeStyleVC = LifeStyleViewController()
    
    private var personalVC = PersonalViewController()
    
    var vc: [UIViewController] = []
    
    var nowVC: Int = BottomItems.ImmediateBloodSugarViewController.rawValue
    
    var isViewShifted = false  // 布尔变量，用于跟踪视图是否已经偏移
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.backBarButtonItem = nil
        vc = [personalVC, lifeStyleVC, immediateBloodSugarVC, bloodSugarCorrectVC, histroyVC]
    
        updateView(2)
        customTabBar.buttonTapped = { [self] in
            let page = $0
            if $0 != self.nowVC {
                self.pageChange(page: $0)
            }
        }
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
        vMenu.layer.shadowColor = UIColor.gray.cgColor // 設置陰影顏色
        vMenu.layer.shadowOffset = CGSize(width: 0, height: 2) // 設置陰影偏移
        vMenu.layer.shadowRadius = 4.0 // 設置陰影半徑
        vMenu.layer.shadowOpacity = 0.9 // 設置陰影透明度
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.tintColor = .white
        // 設定NavigationBar
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = UIColor.mainColor
        barAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        // 應用於導航欄的標準狀態
        navigationController?.navigationBar.standardAppearance = barAppearance
        // 應用於導航欄的滾動邊緣狀態
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        let imageSize = CGSize(width: 25, height: 25) // 指定所需的圖片大小

        let imgLink = resizeImage(image: UIImage(named: "link")!.withRenderingMode(.alwaysOriginal),
                                  targetSize: imageSize)

        let imgThreeLine = resizeImage(image: UIImage(named: "ThreeLineSmall")!.withRenderingMode(.alwaysOriginal),
                                       targetSize: imageSize)

        let btnThreeLine = UIButton(type: .custom)
        btnThreeLine.setImage(imgThreeLine, for: .normal)
        btnThreeLine.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        btnThreeLine.addTarget(self,
                               action: #selector(indicatePage),
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
    
    func pageChange(page: Int) {
        updateView(page)
    }
    
    func updateView(_ index: Int) {
        
        switch index{
        case 0:
            navigationItem.title = "歷史紀錄"
        case 1:
            navigationItem.title = "血糖校正"
        case 2:
            navigationItem.title = "即時血糖"
        case 3:
            navigationItem.title = "生活作息"
        default:
            navigationItem.title = "個人資訊"
        }
        
        nowVC = index
        if children.first(where: { String(describing: $0.classForCoder) == String(describing: vc[index].classForCoder) }) == nil {
            addChild(vc[index])
            vc[index].view.frame = container.bounds
        }
        container.addSubview(vc[index].view ?? UIView())
    }
    
    // MARK: - IBAction
    
    @objc func indicatePage() {
        if isViewShifted {
            UIView.animate(withDuration: 0.3) {
                self.vMenu.transform = .identity
            }
        } else {
//            let shiftAmount: CGFloat = 100.0  // 可以根据需要调整偏移量
            UIView.animate(withDuration: 0.3) { [self] in
                self.vMenu.transform = CGAffineTransform(translationX: vMenu.frame.width, y: 0)
            }
        }
        // 切换状态
        isViewShifted.toggle()
        
    }
    
    @objc func button2Tapped() {
        // 处理按钮2的点击事件
        print("hello2")
        
    }
}
// MARK: - Extension

// MARK: - Protocol



