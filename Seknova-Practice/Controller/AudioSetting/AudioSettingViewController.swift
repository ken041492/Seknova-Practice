//
//  AudioSettingViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/24.
//

import UIKit

class AudioSettingViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tbvAudio: UITableView!
    
    // MARK: - Variables
    
    let audioArray: [String] = ["-", "sound1", "sound2", "sound3", "sound4"]
    
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
        tbvAudio.register(UINib(nibName: "HighBloodSwitchTableViewCell",
                                    bundle: nil),
                              forCellReuseIdentifier: HighBloodSwitchTableViewCell.identifier)
        
        tbvAudio.register(UINib(nibName: "HighBloodLabelTableViewCell",
                                    bundle: nil),
                              forCellReuseIdentifier: HighBloodLabelTableViewCell.identifier)
        
        tbvAudio.register(UINib(nibName: "PickerViewTableViewCell",
                                    bundle: nil),
                              forCellReuseIdentifier: PickerViewTableViewCell.identifier)
        
        tbvAudio.delegate = self
        tbvAudio.dataSource = self
        
        selectValue = UserPreferences.shared.bellSetting
        initialIndex = audioArray.firstIndex(of: selectValue) ?? 0
        storeAlert = UserPreferences.shared.isOverride
    }
    
    func setupNavigation() {
        title = "鈴聲設置"
        let backButton = UIBarButtonItem()
        backButton.title = "返回"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let rightButtonItem = UIBarButtonItem(title: "儲存", style: .plain, target: self, action: #selector(saveData))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    // MARK: - IBAction
    @objc func saveData() {
        UserPreferences.shared.isOverride = storeAlert
        UserPreferences.shared.bellSetting = selectValue
        NotificationCenter.default.post(name: NotificationNames.updateSetting, object: nil)
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
        storeAlert = sender.isOn
    }
}
// MARK: - Extension

extension AudioSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    // 每個cell 的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            if indexPath.row == 1 {
                return 200
            } else {
                return 45
            }
        case 0:
            return 45
        default:
            return 0
        }
    }
    // 每個header 的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 100
        case 1:
            return 30
        default:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        // 調整文本的位置
        label.frame = CGRect(x: 20, y: -20, width: tableView.bounds.size.width - 40, height: 40)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping // 設置換行方式為單詞換行
        
        switch section {
        case 0:
            label.text = "Override ringer setting to always play a tone,even when your ringer is silenced."
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = UIColor.black
            label.frame = CGRect(x: 20, y: 30, width: tableView.bounds.size.width - 40, height: 60)
        case 1:
            label.text = "Note: the Urgent Low Alert will always override your ringer,\n regardless of this setting."
        default:
            label.text = "OPTIONS"
        }
        
        headerView.addSubview(label)
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == 1 {
            let cell = tbvAudio.dequeueReusableCell(withIdentifier: HighBloodSwitchTableViewCell.identifier, for: indexPath) as! HighBloodSwitchTableViewCell
            cell.lbTitle.text = "Override"
            cell.switchChange.addTarget(self,
                                        action: #selector(switchChanged),
                                        for: .valueChanged)
            cell.switchChange.isOn = storeAlert
            cell.selectionStyle = .none
            return cell
        } else {
            if indexPath.row == 0 {
                let cell = tbvAudio.dequeueReusableCell(withIdentifier: HighBloodLabelTableViewCell.identifier, for: indexPath) as! HighBloodLabelTableViewCell
                cell.lbTitle.text = "鈴聲設置"
                
                if selectValue == "-" {
                    cell.lbContent.text = selectValue
                } else if selectValue == "" {
                    cell.lbContent.text = UserPreferences.shared.bellSetting
                } else {
                    cell.lbContent.text = selectValue
                }
                
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tbvAudio.dequeueReusableCell(withIdentifier: PickerViewTableViewCell.identifier, for: indexPath) as! PickerViewTableViewCell
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




extension AudioSettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return audioArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
      titleForRow row: Int, forComponent component: Int)
    -> String? {
        return audioArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView,didSelectRow row: Int, inComponent component: Int) {
        isEdit = true
        selectValue = audioArray[row]
        tbvAudio.reloadData()
    }
}
// MARK: - Protocol


