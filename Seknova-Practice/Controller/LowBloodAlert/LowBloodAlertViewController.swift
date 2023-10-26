//
//  LowBloodAlertViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/25.
//

import UIKit

class LowBloodAlertViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tbvLowBlood: UITableView!
   
    
    // MARK: - Variables
    
    var lowBloodArray: [String] = []

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
        tbvLowBlood.register(UINib(nibName: "HighBloodSwitchTableViewCell",
                                    bundle: nil),
                              forCellReuseIdentifier: HighBloodSwitchTableViewCell.identifier)
        
        tbvLowBlood.register(UINib(nibName: "HighBloodLabelTableViewCell",
                                    bundle: nil),
                              forCellReuseIdentifier: HighBloodLabelTableViewCell.identifier)
        
        tbvLowBlood.register(UINib(nibName: "PickerViewTableViewCell",
                                    bundle: nil),
                              forCellReuseIdentifier: PickerViewTableViewCell.identifier)
        
        tbvLowBlood.delegate = self
        tbvLowBlood.dataSource = self
        lowBloodArray.append("-")
        for number in stride(from: 70, through: 90, by: 5) {
            lowBloodArray.append(String(number))
        }
       
        selectValue = UserPreferences.shared.lowLimit
        initialIndex = lowBloodArray.firstIndex(of: selectValue) ?? 0
        storeAlert = UserPreferences.shared.lowAlert
    }
    
    func setupNavigation() {
        title = "低血糖警示"
        let backButton = UIBarButtonItem()
        backButton.title = "返回"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let rightButtonItem = UIBarButtonItem(title: "儲存", style: .plain, target: self, action: #selector(saveData))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    // MARK: - IBAction
    @objc func saveData() {
        UserPreferences.shared.lowAlert = storeAlert
        UserPreferences.shared.lowLimit = selectValue
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
        storeAlert = sender.isOn
    }
}
// MARK: - Extension

extension LowBloodAlertViewController: UITableViewDelegate, UITableViewDataSource {
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
            return "低血糖警示"
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
            let cell = tbvLowBlood.dequeueReusableCell(withIdentifier: HighBloodSwitchTableViewCell.identifier, for: indexPath) as! HighBloodSwitchTableViewCell
            cell.lbTitle.text = "低血糖警示"
            cell.switchChange.addTarget(self,
                                        action: #selector(switchChanged),
                                        for: .valueChanged)
            cell.switchChange.isOn = storeAlert
            cell.selectionStyle = .none
            return cell
        default:
            if indexPath.row == 0 {
                let cell = tbvLowBlood.dequeueReusableCell(withIdentifier: HighBloodLabelTableViewCell.identifier, for: indexPath) as! HighBloodLabelTableViewCell
                cell.lbTitle.text = "Low Limit"
                cell.lbContent.textColor = .systemBlue

                if selectValue == "-" {
                    cell.lbContent.text = selectValue
                } else if selectValue == "" {
                    cell.lbContent.text = UserPreferences.shared.lowLimit
                    if UserPreferences.shared.lowLimit != "-" {
                        cell.lbContent.text! += " mg/dL"
                    }
                } else {
                    cell.lbContent.text = selectValue + " mg/dL"
                    
                }
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tbvLowBlood.dequeueReusableCell(withIdentifier: PickerViewTableViewCell.identifier, for: indexPath) as! PickerViewTableViewCell
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

extension LowBloodAlertViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lowBloodArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
      titleForRow row: Int, forComponent component: Int)
    -> String? {
        return lowBloodArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView,didSelectRow row: Int, inComponent component: Int) {
        isEdit = true
        selectValue = lowBloodArray[row]
        tbvLowBlood.reloadData()
    }
}
// MARK: - Protocol


