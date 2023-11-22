//
//  BloodCorrectViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/2.
//

import UIKit

class BloodCorrectViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var txfValue: UITextField!
    
    @IBOutlet weak var btnValueUp: UIButton!
    
    @IBOutlet weak var btnValueDown: UIButton!
    
    @IBOutlet weak var btnUnderstand: UIButton!
    
    @IBOutlet weak var btnStore: UIButton!
    
    // MARK: - Variables
    
    var timer: Timer?
    var isIncrementing = false
    
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
        btnStore.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        btnUnderstand.setTitle(NSLocalizedString("Understand More", comment: ""), for: .normal)
        setupViewShadow(txfValue)
        
        // 添加长按手势识别器
        let incrementLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(incrementLongPressHandler(_:)))
        btnValueUp.addGestureRecognizer(incrementLongPressGesture)
        
        let decrementLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(decrementLongPressHandler(_:)))
        btnValueDown.addGestureRecognizer(decrementLongPressGesture)
    }
    
    func setupNavigation() {
        
    }
    
    func setupViewShadow(_ sender: UITextField) {
        sender.layer.shadowColor = UIColor.gray.cgColor // 设置阴影颜色
        sender.layer.shadowOffset = CGSize(width: 0, height: 0) // 设置阴影偏移
        sender.layer.shadowRadius = 6.0 // 设置阴影半径
        sender.layer.shadowOpacity = 0.9 // 设置阴影透明度
    }
    
    // MARK: - IBAction
    
    @IBAction func storeData(_ sender: Any) {
        
        if Int(txfValue.text!)! < 55 || Int(txfValue.text!)! > 400 {
            Alert().showAlert(title: NSLocalizedString("Please enter the correct index", comment: ""), message: NSLocalizedString("The entered index must be between 55 ~ 400", comment: ""), vc: self)
        } else {
            let BloodSugarConfirmVC = BloodSugarConfirmViewController()
            BloodSugarConfirmVC.storeBloodSugar = txfValue.text
            navigationController?.pushViewController(BloodSugarConfirmVC, animated: true)
        }
    }
    
    @IBAction func understandMuch(_ sender: Any) {
        
        let popoverVC = UIViewController()
        popoverVC.view.backgroundColor = UIColor.white
        popoverVC.preferredContentSize = CGSize(width: view.frame.width - 80,
                                                height: view.frame.height / 4)
        
        // 在弹出视图中创建一个 UILabel
        let titleLabel = UILabel()
        titleLabel.text = ""
        titleLabel.font = UIFont.systemFont(ofSize: 20) // 设置文字大小为 20 points
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let contentLabel = UILabel()
        contentLabel.text = NSLocalizedString("CalibrateUnderstandMore", comment: "")
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .left
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        // 将 label 添加到 popoverVC 的视图中
        
        popoverVC.view.addSubview(titleLabel)
        popoverVC.view.addSubview(contentLabel)

        // 使用 Auto Layout 进行布局
    
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: popoverVC.view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: popoverVC.view.topAnchor, constant: 5),
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5), // 添加垂直间距的约束
            contentLabel.leadingAnchor.constraint(equalTo: popoverVC.view.leadingAnchor, constant: 10), // 添加 leading 约束
            contentLabel.trailingAnchor.constraint(equalTo: popoverVC.view.trailingAnchor, constant: -10), // 添加 trailing 约束
            contentLabel.bottomAnchor.constraint(equalTo: popoverVC.view.bottomAnchor, constant: -25) // 添加 bottom 约束
        ])
        
        // 以彈出視窗的形式顯示在目前視圖控制器上
        popoverVC.modalPresentationStyle = .popover
        let popoverPresentationController = popoverVC.popoverPresentationController
        // 從當前view 彈出 對齊button
        popoverPresentationController!.sourceView = btnUnderstand // 使用按钮作为源视图
        popoverPresentationController?.sourceRect = btnUnderstand.bounds
        popoverPresentationController?.permittedArrowDirections = .down
        popoverPresentationController?.delegate = self
        // 显示弹出视图
        present(popoverVC, animated: true, completion: nil)
    }
    
    @objc func incrementLongPressHandler(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            isIncrementing = true
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(incrementValue), userInfo: nil, repeats: true)
        } else if sender.state == .ended {
            isIncrementing = false
            timer?.invalidate()
        }
    }

    @objc func decrementLongPressHandler(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            isIncrementing = false
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(decrementValue), userInfo: nil, repeats: true)
        } else if sender.state == .ended {
            isIncrementing = false
            timer?.invalidate()
        }
    }

    @objc func incrementValue() {
        txfValue.text = String(Int(txfValue.text!)! + 1)
    }

    @objc func decrementValue() {
        txfValue.text = String(Int(txfValue.text!)! - 1)
    }
    
    @IBAction func valueUp(_ sender: Any) {
        txfValue.text = String(Int(txfValue.text!)! + 1)
    }
    @IBAction func valueDown(_ sender: Any) {
         txfValue.text = String(Int(txfValue.text!)! - 1)
    }
    
}
// MARK: - Extension

extension BloodCorrectViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
// MARK: - Protocol


