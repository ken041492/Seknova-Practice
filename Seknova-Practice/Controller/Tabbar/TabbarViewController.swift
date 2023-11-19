//
//  TabbarViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/2.
//

import UIKit

import BatteryView

import RealmSwift

class TabbarViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var customTabBar: CustomTabBar!
    
    @IBOutlet weak var vMenu: UIView!
    
    @IBOutlet weak var btnForm: UIButton!
    
    @IBOutlet weak var btnLogs: UIButton!
    
    @IBOutlet weak var btnSetting: UIButton!
    
    // MARK: - Variables
    
    private var histroyVC = HistoryViewController()
    
    private var bloodSugarCorrectVC = BloodCorrectViewController()
    
    private var immediateBloodSugarVC = BloodImmediateViewController()
    
    private var lifeStyleVC = LifeStyleViewController()
    
    private var personalVC = PersonalViewController()
    
    var vc: [UIViewController] = []
    
    var nowVC: Int = BottomItems.ImmediateBloodSugarViewController.rawValue
    
    var isViewShifted = false  // 布尔变量，用于跟踪视图是否已经偏移
    
    var customCircleBarItem: UIBarButtonItem?
        
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.backBarButtonItem = nil
        vc = [histroyVC, bloodSugarCorrectVC, immediateBloodSugarVC, lifeStyleVC, personalVC]
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

        var imgLink: UIImage?
        
        if(UserPreferences.shared.isPair){
            imgLink = resizeImage(image: UIImage(named: "link")!.withRenderingMode(.alwaysOriginal),
                                      targetSize: imageSize)
        } else {
            imgLink = resizeImage(image: UIImage(named: "unlink")!.withRenderingMode(.alwaysOriginal),
                                 targetSize: imageSize)
        }
        
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
        
        let customCircleView = setupCircle(radius: 10)
        customCircleBarItem = UIBarButtonItem(customView: customCircleView)
        navigationItem.rightBarButtonItem = customCircleBarItem
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
            let rightButtonItem = UIBarButtonItem(image: resizeImage(image: UIImage(named: "reload")!, targetSize: CGSize(width: 25, height: 25)), style: .plain, target: self, action: #selector(reloadHistory))
            navigationItem.rightBarButtonItem = rightButtonItem
            navigationItem.title = "歷史紀錄"
        case 1:
            navigationItem.title = "血糖校正"
            navigationItem.rightBarButtonItem = nil
        case 2:
            let customCircleView = setupCircle(radius: 10)
            customCircleBarItem = UIBarButtonItem(customView: customCircleView)
            navigationItem.rightBarButtonItem = customCircleBarItem
            navigationItem.title = "即時血糖"
        case 3:
            let rightButtonItem = UIBarButtonItem(title: "事件記錄", style: .plain, target: self, action: #selector(eventRecord))
            navigationItem.rightBarButtonItem = rightButtonItem
            navigationItem.title = "生活作息"
        default:
            let rightButtonItem = UIBarButtonItem(title: "更新", style: .plain, target: self, action: #selector(updateTbv))
            navigationItem.rightBarButtonItem = rightButtonItem
            navigationItem.title = "個人資訊"
        }
        
        nowVC = index
        if children.first(where: { String(describing: $0.classForCoder) == String(describing: vc[index].classForCoder) }) == nil {
            addChild(vc[index])
            vc[index].view.frame = container.bounds
            
        }
        container.addSubview(vc[index].view ?? UIView())
    }
    
    func setupCircle(radius: Double) -> UIView {
        
        let aDegree = Double.pi / 180
        let lineWidth: Double = radius / 2
        let radius: Double = radius
        var startDegree: Double = 270
        let viewWidth = 2 * (radius + lineWidth)

        let center = CGPoint(x: lineWidth + radius, y: lineWidth + radius)
        
        // 创建一个容器视图，用于包含所有的图层
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth))
        
        // 灰色底圈
        let grayCirclePath = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        let grayCircleLayer = CAShapeLayer()
        grayCircleLayer.path = grayCirclePath.cgPath
        grayCircleLayer.strokeColor = UIColor.lightGray.cgColor
        grayCircleLayer.lineWidth = lineWidth
        grayCircleLayer.fillColor = UIColor.clear.cgColor
        containerView.layer.addSublayer(grayCircleLayer)
        
        // 创建外部圆圈
        let outerCirclePath = UIBezierPath(arcCenter: center, radius: CGFloat(radius + lineWidth / 2), startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        let outerCircleLayer = CAShapeLayer()
        outerCircleLayer.path = outerCirclePath.cgPath
        outerCircleLayer.strokeColor = UIColor.black.cgColor
        outerCircleLayer.lineWidth = 1
        outerCircleLayer.fillColor = UIColor.clear.cgColor
        containerView.layer.addSublayer(outerCircleLayer)
        
        // 設定填充的顏色和範圍
        let endDegree = startDegree + 360 * 50 / 100
        let percentagePath = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: aDegree * startDegree, endAngle: aDegree * endDegree, clockwise: true)
        let percentageLayer = CAShapeLayer()
        percentageLayer.path = percentagePath.cgPath
        percentageLayer.strokeColor = UIColor.green.cgColor
        percentageLayer.lineWidth = lineWidth
        percentageLayer.fillColor = UIColor.clear.cgColor
        containerView.layer.addSublayer(percentageLayer)
        
        startDegree = endDegree

        let endDegree2 = startDegree + 360 * 50 / 100
        let percentagePath2 = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: aDegree * (startDegree + 30), endAngle: aDegree * endDegree2, clockwise: true)
        let percentageLayer2 = CAShapeLayer()
        percentageLayer2.path = percentagePath2.cgPath
        percentageLayer2.strokeColor = UIColor.green.cgColor
        percentageLayer2.lineWidth = lineWidth
        percentageLayer2.fillColor = UIColor.clear.cgColor
        
        containerView.layer.addSublayer(percentageLayer2)
        startDegree = endDegree2
        // 创建內部圆圈
        let interCirclePath = UIBezierPath(arcCenter: center, radius: CGFloat((lineWidth + radius) / 2), startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        let interCircleLayer = CAShapeLayer()
        interCircleLayer.path = interCirclePath.cgPath
        interCircleLayer.strokeColor = UIColor.black.cgColor
        interCircleLayer.lineWidth = 1
        interCircleLayer.fillColor = UIColor.clear.cgColor
        containerView.layer.addSublayer(interCircleLayer)
        
        // 计算分界线的结束点坐标
        let dividerX = center.x
        let dividerY = center.y - radius - lineWidth / 2

        // 创建分界线
        let dividerPath = UIBezierPath()
        dividerPath.move(to: CGPoint(x: dividerX, y: dividerY + lineWidth)) // 起点
        dividerPath.addLine(to: CGPoint(x: dividerX, y: dividerY)) // 终点

        let dividerLayer = CAShapeLayer()
        dividerLayer.path = dividerPath.cgPath
        dividerLayer.strokeColor = UIColor.black.cgColor
        dividerLayer.lineWidth = 2
        dividerLayer.fillColor = UIColor.clear.cgColor
        containerView.layer.addSublayer(dividerLayer)
        
        // 计算分界线的结束点坐标

        let dividerY1 = center.y + radius + lineWidth / 2

        // 创建分界线
        let dividerPath1 = UIBezierPath()
        dividerPath1.move(to: CGPoint(x: dividerX, y: dividerY1 - lineWidth)) // 起点
        dividerPath1.addLine(to: CGPoint(x: dividerX, y: dividerY1)) // 终点

        let dividerLayer1 = CAShapeLayer()
        dividerLayer1.path = dividerPath1.cgPath
        dividerLayer1.strokeColor = UIColor.black.cgColor
        dividerLayer1.lineWidth = 2
        dividerLayer1.fillColor = UIColor.clear.cgColor
//        view.layer.addSublayer(dividerLayer1)
        containerView.layer.addSublayer(dividerLayer1)
        
        // 创建一个点击手势识别器
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(indicateSchedule))
        containerView.addGestureRecognizer(tapGesture)
        
        return containerView
    }
    
    // MARK: - IBAction
    
    @objc func indicatePage() {
        if isViewShifted {
            UIView.animate(withDuration: 0.3) {
                self.vMenu.transform = .identity
            }
        } else {
            UIView.animate(withDuration: 0.3) { [self] in
                self.vMenu.transform = CGAffineTransform(translationX: vMenu.frame.width, y: 0)
            }
        }
        // 切换状态
        isViewShifted.toggle()
    }
    
    @objc func button2Tapped() {
        // 处理按钮2的点击事件
        let popoverVC = UIViewController()
        popoverVC.view.backgroundColor = UIColor.white
        
        // 在弹出视图中创建一个 UILabel
        let contentLabel = UILabel()
        // 将 label 添加到 popoverVC 的视图中
        popoverVC.view.addSubview(contentLabel)
        
        if(UserPreferences.shared.deviceID == ""){
            popoverVC.preferredContentSize = CGSize(width: view.frame.width / 2,
                                                    height: view.frame.height / 10)
            contentLabel.text = "發射器尚未啟用，請使用者啟用後才可以進一步顯示資料。"
        } else if(!UserPreferences.shared.isPair){
            popoverVC.preferredContentSize = CGSize(width: view.frame.width / 2,
                                                    height: view.frame.height / 10)
            contentLabel.text = "感測器尚未啟用，請使用者先行啟用後才可以顯示資料。"
        } else {
            popoverVC.preferredContentSize = CGSize(width: view.frame.width / 2,
                                                    height: view.frame.height / 14)
            contentLabel.text = "感測器已啟用"
        }
        
        if(UserPreferences.shared.deviceID == "" ||
           UserPreferences.shared.isPair){
            // 感測器未啟用的Layout
            NSLayoutConstraint.activate([
                contentLabel.topAnchor.constraint(equalTo: popoverVC.view.topAnchor, constant: 30), // 添加垂直间距的约束
                contentLabel.leadingAnchor.constraint(equalTo: popoverVC.view.leadingAnchor, constant: 10), // 添加 leading 约束
                contentLabel.trailingAnchor.constraint(equalTo: popoverVC.view.trailingAnchor, constant: -10), // 添加 trailing 约束
            ])

        } else {
           // 感測器已啟用的Layout
           NSLayoutConstraint.activate([
               contentLabel.centerXAnchor.constraint(equalTo: popoverVC.view.centerXAnchor),
               contentLabel.centerYAnchor.constraint(equalTo: popoverVC.view.centerYAnchor),
           ])
       }
        
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .center
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 以彈出視窗的形式顯示在目前視圖控制器上
        popoverVC.modalPresentationStyle = .popover
        let popoverPresentationController = popoverVC.popoverPresentationController
        // 從當前view 彈出 對齊button
        
        if let leftBarButtonItem = navigationItem.leftBarButtonItems?[1] {
            popoverPresentationController?.barButtonItem = leftBarButtonItem
        }
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.delegate = self
        // 显示弹出视图
        present(popoverVC, animated: true, completion: nil)
    }
    
    @IBAction func jumpToForm(_ sender: Any) {
        let formVC = FormViewController()
        UIView.animate(withDuration: 0.3) {
            self.vMenu.transform = .identity
        }
        isViewShifted.toggle()
        navigationController?.pushViewController(formVC, animated: true)
    }
    
    @IBAction func jumpToLogs(_ sender: Any) {
        let logsVC = LogsViewController()
        UIView.animate(withDuration: 0.3) {
            self.vMenu.transform = .identity
        }
        isViewShifted.toggle()
        navigationController?.pushViewController(logsVC, animated: true)
    }
    
    @IBAction func jumpToSetting(_ sender: Any) {
        let settingVC = SettingViewController()
        UIView.animate(withDuration: 0.3) {
            self.vMenu.transform = .identity
        }
        isViewShifted.toggle()
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    @objc func indicateSchedule(){
        
        let popoverVC = UIViewController()
        popoverVC.view.backgroundColor = UIColor.white
        popoverVC.preferredContentSize = CGSize(width: view.frame.width - 200,
                                                height: view.frame.width - 200)
        // 建立最上面的label
        let titleLabel = UILabel()
        titleLabel.text = "10 Day"
        titleLabel.font = UIFont.systemFont(ofSize: 16) // 设置文字大小为 16 points
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        // 建立底下的label
        let lbContent = UILabel()
        lbContent.text = "Calibrated Now"
        lbContent.font = UIFont.systemFont(ofSize: 20) // 设置文字大小为 16 points
        lbContent.textAlignment = .center
        lbContent.translatesAutoresizingMaskIntoConstraints = false
        // 建立日曆的ImageView
        let imgvDeadline = UIImageView()
        imgvDeadline.image = resizeImage(image: UIImage(named: "deadline")!.withRenderingMode(.alwaysOriginal),
                                      targetSize: CGSize(width: 40, height: 40))  // 设置图像
        imgvDeadline.contentMode = .scaleAspectFit  // 设置图像的显示模式，根据需要进行调整
        imgvDeadline.translatesAutoresizingMaskIntoConstraints = false  // 关闭自动布局
       // 建立血滴的ImageView
        let imgvBlood = UIImageView()
        imgvBlood.image = resizeImage(image: UIImage(named: "blood")!.withRenderingMode(.alwaysOriginal), targetSize: CGSize(width: 40, height: 40))
        imgvBlood.contentMode = .scaleAspectFit
        imgvBlood.translatesAutoresizingMaskIntoConstraints = false
        // 設置圓形進度的View
//        let circleView = setupCircle(radius: 45)
        let circleView = setupCircle(radius: popoverVC.preferredContentSize.width / 4)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        // 設置電池的View
        let batteryView = BatteryView(frame: CGRect(x: popoverVC.preferredContentSize.width / 2 - 10,
                                                    y: popoverVC.preferredContentSize.height / 2 - 10,
                                                    width: 30,
                                                    height: 40))
        batteryView.noLevelText = "?"

        // 添加父视图到你的界面中，如 popoverVC 或其他视图控制器的视图中
        popoverVC.view.addSubview(titleLabel)
        popoverVC.view.addSubview(circleView)
        popoverVC.view.addSubview(imgvDeadline)
        popoverVC.view.addSubview(imgvBlood)
        popoverVC.view.addSubview(lbContent)
        popoverVC.view.addSubview(batteryView)
        // 使用 Auto Layout 进行布局
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: popoverVC.view.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: popoverVC.view.topAnchor, constant: 20),
            circleView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            circleView.leadingAnchor.constraint(equalTo: popoverVC.view.leadingAnchor, constant: popoverVC.preferredContentSize.width / 7),
            lbContent.bottomAnchor.constraint(equalTo: popoverVC.view.bottomAnchor, constant: -10),
            lbContent.centerXAnchor.constraint(equalTo: popoverVC.view.centerXAnchor),
            imgvDeadline.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            imgvDeadline.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            imgvBlood.bottomAnchor.constraint(equalTo: lbContent.topAnchor, constant: -10),
            imgvBlood.leadingAnchor.constraint(equalTo: lbContent.leadingAnchor, constant: -20)
        ])
        
        if(UserPreferences.shared.isPair){
            batteryView.isHidden = true
        } else {
            batteryView.isHidden = false
        }
        // 以彈出視窗的形式顯示在目前視圖控制器上
        popoverVC.modalPresentationStyle = .popover
        let popoverPresentationController = popoverVC.popoverPresentationController
        // 從當前view 彈出 對齊button
        if let rightBarButtonItem = navigationItem.rightBarButtonItem {
            popoverPresentationController?.barButtonItem = rightBarButtonItem
        }
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.delegate = self
        // 显示弹出视图
        present(popoverVC, animated: true, completion: nil)
    }
    
    @objc func updateTbv() {
        NotificationCenter.default.post(name: NotificationNames.infoDataUpdated, object: nil)
    }
    
    @objc func eventRecord() {
        let eventRecordVC = EventRecordViewController()
        navigationController?.pushViewController(eventRecordVC, animated: true)
    }
    
    @objc func reloadHistory() {
        NotificationCenter.default.post(name: NotificationNames.updateHistory, object: nil)
    }
}
// MARK: - Extension

extension TabbarViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: - Protocol



