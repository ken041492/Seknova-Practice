//
//  HighBloodAlertViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/24.
//

import UIKit

class HighBloodAlertViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tbvHighBlood: UITableView!
    
    // MARK: - Variables
    
    var highBloodArray: [String] = []

    var selectValue: String = ""
    
    var storeAlert: Bool = false
    
    var initialIndex: Int = 0
    
    var isEdit: Bool = false

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
        tbvHighBlood.register(UINib(nibName: "HighBloodSwitchTableViewCell",
                                    bundle: nil),
                              forCellReuseIdentifier: HighBloodSwitchTableViewCell.identifier)
        
        tbvHighBlood.register(UINib(nibName: "HighBloodLabelTableViewCell",
                                    bundle: nil),
                              forCellReuseIdentifier: HighBloodLabelTableViewCell.identifier)
        
        tbvHighBlood.register(UINib(nibName: "PickerViewTableViewCell",
                                    bundle: nil),
                              forCellReuseIdentifier: PickerViewTableViewCell.identifier)
        
        tbvHighBlood.delegate = self
        tbvHighBlood.dataSource = self
        highBloodArray.append("-")
        for number in stride(from: 150, through: 250, by: 5) {
            highBloodArray.append(String(number))
        }
        selectValue = UserPreferences.shared.highLimit
        initialIndex = highBloodArray.firstIndex(of: selectValue) ?? 0
        storeAlert = UserPreferences.shared.highAlert
    }
    
    func setupNavigation() {
        title = "高血糖警示"
        let backButton = UIBarButtonItem()
        backButton.title = "返回"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let rightButtonItem = UIBarButtonItem(title: "儲存", style: .plain, target: self, action: #selector(saveData))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    // MARK: - IBAction
    @objc func saveData() {
        UserPreferences.shared.highAlert = storeAlert
        UserPreferences.shared.highLimit = selectValue
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
        storeAlert = sender.isOn
    }
}
// MARK: - Extension

extension HighBloodAlertViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    // 每個cell 的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            if indexPath.row == 1 {
                return 200
            } else {
                return 45
            }
        default:
            return 45
        }
    }
    // 每個header 的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else {
            return "高血糖警示"
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tbvHighBlood.dequeueReusableCell(withIdentifier: HighBloodSwitchTableViewCell.identifier, for: indexPath) as! HighBloodSwitchTableViewCell
            cell.lbTitle.text = "高血糖警示"
            cell.switchChange.addTarget(self,
                                        action: #selector(switchChanged),
                                        for: .valueChanged)
            cell.switchChange.isOn = storeAlert
            cell.selectionStyle = .none
            return cell
        default:
            if indexPath.row == 0 {
                let cell = tbvHighBlood.dequeueReusableCell(withIdentifier: HighBloodLabelTableViewCell.identifier, for: indexPath) as! HighBloodLabelTableViewCell
                cell.lbTitle.text = "High Limit"
                cell.lbContent.textColor = .systemBlue
                
                if selectValue == "-" {
                    cell.lbContent.text = selectValue
                } else if selectValue == "" {
                    cell.lbContent.text = UserPreferences.shared.highLimit
                    if UserPreferences.shared.highLimit != "-" {
                        cell.lbContent.text! += " mg/dL"
                    }
                } else {
                    cell.lbContent.text = selectValue + " mg/dL"
                }
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tbvHighBlood.dequeueReusableCell(withIdentifier: PickerViewTableViewCell.identifier, for: indexPath) as! PickerViewTableViewCell
                cell.pkvHighLimit.delegate = self
                cell.pkvHighLimit.dataSource = self
                if !isEdit {
                    cell.pkvHighLimit.selectRow(initialIndex,
                                                inComponent: 0, animated: false)
                }
                cell.selectionStyle = .none
                return cell
            }
        }
    }
}

extension HighBloodAlertViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return highBloodArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
      titleForRow row: Int, forComponent component: Int)
    -> String? {
        return highBloodArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView,didSelectRow row: Int, inComponent component: Int) {
        isEdit = true
        selectValue = highBloodArray[row]
        tbvHighBlood.reloadData()
    }
}
// MARK: - Protocol


