//
//  RateAlertViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/24.
//

import UIKit

class RateAlertViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tbvRateAlert: UITableView!
    
    // MARK: - Variables
    
    var storeRiseAlert: Bool = false
    
    var storeFallAlert: Bool = false
    
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
        tbvRateAlert.register(UINib(nibName: "HighBloodSwitchTableViewCell",
                                    bundle: nil),
                              forCellReuseIdentifier: HighBloodSwitchTableViewCell.identifier)
        tbvRateAlert.delegate = self
        tbvRateAlert.dataSource = self
        
        storeRiseAlert = UserPreferences.shared.riseAlert
        storeFallAlert = UserPreferences.shared.fallAlert
    }
    
    func setupNavigation() {
        title = NSLocalizedString("Rate Alerts", comment: "")
        let backButton = UIBarButtonItem()
        backButton.title = NSLocalizedString("Return", comment: "")
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let rightButtonItem = UIBarButtonItem(title: NSLocalizedString("Save", comment: ""), style: .plain, target: self, action: #selector(saveData))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    // MARK: - IBAction
    @objc func saveData() {
        UserPreferences.shared.riseAlert = storeRiseAlert
        UserPreferences.shared.fallAlert = storeFallAlert
        NotificationCenter.default.post(name: NotificationNames.updateSetting, object: nil)
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
        if sender.tag == 0 {
            storeRiseAlert = sender.isOn
        } else {
            storeFallAlert = sender.isOn
        }
    }
}
// MARK: - Extension
extension RateAlertViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    // 每個cell 的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    // 每個header 的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        } else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        // 調整文本的位置
        label.frame = CGRect(x: 20, y: -10, width: tableView.bounds.size.width , height: 20)
        
        switch section {
        case 0:
            label.text = ""
        case 1:
            label.text = "Alert when sensor glucose is rising quickly"
        default:
            label.text = "Alert when sensor glucose is falling quickly"
        }
        
        headerView.addSubview(label)
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbvRateAlert.dequeueReusableCell(withIdentifier: HighBloodSwitchTableViewCell.identifier, for: indexPath) as! HighBloodSwitchTableViewCell
        cell.lbTitle.text = "低血糖警示"
        cell.switchChange.addTarget(self,
                                    action: #selector(switchChanged),
                                    for: .valueChanged)
        if indexPath.section == 0 {
            cell.switchChange.tag = 0
            cell.lbTitle.text = "Rise Alert"
            cell.switchChange.isOn = storeRiseAlert
        }
        
        if indexPath.section == 1 {
            cell.switchChange.tag = 1
            cell.lbTitle.text = "Fall Alert"
            cell.switchChange.isOn = storeFallAlert
        }
        
        cell.selectionStyle = .none
        return cell
    }
}
// MARK: - Protocol


