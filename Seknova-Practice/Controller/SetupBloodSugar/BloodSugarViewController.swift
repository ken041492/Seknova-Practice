//
//  BloodSugarViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/23.
//

import UIKit

class BloodSugarViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var storeBTN: UIButton!
    
    @IBOutlet weak var understandBTN: UIButton!
    
    @IBOutlet weak var lowBloodView: UIView!
    
    @IBOutlet weak var lowBloodPickerView: UIPickerView!
    
    @IBOutlet weak var highBloodView: UIView!
    
    @IBOutlet weak var highBloodPickerView: UIPickerView!
    
    
    // MARK: - Variables
    let lowSugarBlood = [Int](65 ... 75)
    let highSugarBlood = [Int](150 ... 250)
    
    var storeLowBlood: Int = 70
    var storeHighBlood: Int = 200
    
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
        
        storeBTN.setTitle("儲存", for: .normal)
        understandBTN.setTitle("了解更多", for: .normal)
        
        setupViewShadow(lowBloodView)
        setupViewShadow(highBloodView)
        
        lowBloodPickerView.delegate = self
        lowBloodPickerView.dataSource = self
        highBloodPickerView.delegate = self
        highBloodPickerView.dataSource = self
        
        lowBloodPickerView.selectRow(5, inComponent: 0, animated: false)
        highBloodPickerView.selectRow(50, inComponent: 0, animated: false)
    }
    
    func setupNavigation() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func setupViewShadow(_ sender: UIView) {
        sender.layer.shadowColor = UIColor.gray.cgColor // 设置阴影颜色
        sender.layer.shadowOffset = CGSize(width: 0, height: 0) // 设置阴影偏移
        sender.layer.shadowRadius = 6.0 // 设置阴影半径
        sender.layer.shadowOpacity = 0.9 // 设置阴影透明度
    }
    // MARK: - IBAction
    
    @IBAction func storeData(_ sender: Any) {
        
        UserDefaults.standard.set(storeLowBlood, forKey: "lowSugarBlood")
        UserDefaults.standard.set(storeHighBlood, forKey: "highSugarBlood")
        
        let transmitterVC = TransmitterViewController()
        navigationController?.pushViewController(transmitterVC, animated: true)
    }
    
    @IBAction func understandMuch(_ sender: Any) {
        
        let popoverVC = UIViewController()
        popoverVC.view.backgroundColor = UIColor.white
        popoverVC.preferredContentSize = CGSize(width: view.frame.width - 80,
                                                height: view.frame.height / 4 - 80)
        
        // 在弹出视图中创建一个 UILabel
        let titleLabel = UILabel()
        titleLabel.text = "設定高低血糖值"
        titleLabel.font = UIFont.systemFont(ofSize: 20) // 设置文字大小为 16 points
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let contentLabel = UILabel()
        contentLabel.text = "設定高低血糖值, 系統會於血糖高於高血糖值或是低血糖值時透過通知使用者需進一步處理。通知方式為訊息, 鈴聲(可關掉)或電子郵件訊息"
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .left
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        // 将 label 添加到 popoverVC 的视图中
        
        popoverVC.view.addSubview(titleLabel)
        popoverVC.view.addSubview(contentLabel)

        // 使用 Auto Layout 进行布局
    
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: popoverVC.view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: popoverVC.view.topAnchor, constant: 15),
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10), // 添加垂直间距的约束
            contentLabel.leadingAnchor.constraint(equalTo: popoverVC.view.leadingAnchor, constant: 5), // 添加 leading 约束
            contentLabel.trailingAnchor.constraint(equalTo: popoverVC.view.trailingAnchor, constant: -5) // 添加 trailing 约束
        ])
        
        // 以彈出視窗的形式顯示在目前視圖控制器上
        popoverVC.modalPresentationStyle = .popover
        let popoverPresentationController = popoverVC.popoverPresentationController
        // 從當前view 彈出
        popoverPresentationController?.sourceView = view
        popoverPresentationController?.sourceRect = CGRect(x: view.frame.width / 2,
                                                           y: view.frame.height * 5 / 6, width: 1, height: 1)
        popoverPresentationController?.permittedArrowDirections = .down
        popoverPresentationController?.delegate = self

        // 显示弹出视图
        present(popoverVC, animated: true, completion: nil)
    }
    
    
}
// MARK: - Extension

extension BloodSugarViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == lowBloodPickerView {
            return lowSugarBlood.count
        } else if pickerView == highBloodPickerView {
            return highSugarBlood.count
        }
        return 0
    }
    // UIPickerViewDelegate 方法
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == lowBloodPickerView {
            lowBloodPickerView.subviews[1].backgroundColor = .lowBloodBackground
            lowBloodPickerView.subviews[1].alpha = 0.9
            return "\(lowSugarBlood[row])"
        } else if pickerView == highBloodPickerView {
            highBloodPickerView.subviews[1].backgroundColor = .highBloodBackground
            highBloodPickerView.subviews[1].alpha = 0.9
            return "\(highSugarBlood[row])"
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == lowBloodPickerView {
            storeLowBlood = lowSugarBlood[row]
        } else {
            storeHighBlood = highSugarBlood[row]
        }
    }
    
}

extension BloodSugarViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
// MARK: - Protocol


