//
//  BloodSugarViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/23.
//

import UIKit

class BloodSugarViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var btnStore: UIButton!
    
    @IBOutlet weak var btnUnderstand: UIButton!
    
    @IBOutlet weak var vLowBlood: UIView!
    
    @IBOutlet weak var pkvLowBlood: UIPickerView!
    
    @IBOutlet weak var vHighBlood: UIView!
    
    @IBOutlet weak var pkvHighBlood: UIPickerView!
    
    
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
        
        btnStore.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        btnUnderstand.setTitle(NSLocalizedString("Understand More", comment: ""), for: .normal)
        
        setupViewShadow(vLowBlood)
        setupViewShadow(vHighBlood)
        
        pkvLowBlood.delegate = self
        pkvLowBlood.dataSource = self
        pkvHighBlood.delegate = self
        pkvHighBlood.dataSource = self
        
        pkvLowBlood.selectRow(5, inComponent: 0, animated: false)
        pkvHighBlood.selectRow(50, inComponent: 0, animated: false)
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
        UserPreferences.shared.lowSugarBlood = storeLowBlood
        UserPreferences.shared.highSugarBlood = storeHighBlood
        
        let transmitterVC = TransmitterViewController()
        navigationController?.pushViewController(transmitterVC, animated: true)
    }
    
    @IBAction func understandMuch(_ sender: Any) {
        
        let popoverVC = UIViewController()
        popoverVC.view.backgroundColor = UIColor.white
        // 在弹出视图中创建一个 UILabel
        let titleLabel = UILabel()
        titleLabel.text = NSLocalizedString("Set high and low blood sugar", comment: "")
        titleLabel.font = UIFont.systemFont(ofSize: 20) // 设置文字大小为 20 points
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let contentLabel = UILabel()
        contentLabel.text = NSLocalizedString("SetUpBloodSugarUnderstandMore", comment: "")
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .left
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        // 将 label 添加到 popoverVC 的视图中
        if titleLabel.text?.first == "S" {
            popoverVC.preferredContentSize = CGSize(width: view.frame.width - 80,
                                                    height: view.frame.height / 4)
        } else {
            popoverVC.preferredContentSize = CGSize(width: view.frame.width - 80,
                                                    height: view.frame.height / 6)
        }
        popoverVC.view.addSubview(titleLabel)
        popoverVC.view.addSubview(contentLabel)

        // 使用 Auto Layout 进行布局
    
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: popoverVC.view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: popoverVC.view.topAnchor, constant: 15),
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5), // 添加垂直间距的约束
            contentLabel.leadingAnchor.constraint(equalTo: popoverVC.view.leadingAnchor, constant: 10), // 添加 leading 约束
            contentLabel.trailingAnchor.constraint(equalTo: popoverVC.view.trailingAnchor, constant: -10) // 添加 trailing 约束
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
    
    
}
// MARK: - Extension

extension BloodSugarViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pkvLowBlood {
            return lowSugarBlood.count
        } else if pickerView == pkvHighBlood {
            return highSugarBlood.count
        }
        return 0
    }
    // UIPickerViewDelegate 方法
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pkvLowBlood {
            return "\(lowSugarBlood[row])"
        } else if pickerView == pkvHighBlood {
            return "\(highSugarBlood[row])"
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pkvLowBlood {
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


