//
//  AlertSettingViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/23.
//

import UIKit

class AlertSettingViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tbvAlert: UITableView!
    
    // MARK: - Variables
    
    let titleArray: [String] = ["High Alerts", "Low Alerts"]
   
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTableView),
                                               name: NotificationNames.updateSetting,
                                               object: nil)
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
        tbvAlert.register(UINib(nibName: "AlertTableViewCell", bundle: nil),
                          forCellReuseIdentifier: AlertTableViewCell.identifier)
        
        tbvAlert.delegate = self
        tbvAlert.dataSource = self
    }
    
    func setupNavigation() {
        title = NSLocalizedString("Alert Settings", comment: "")
    }
    
    // MARK: - IBAction
    @objc func reloadTableView() {
        tbvAlert.reloadData()
    }
}
// MARK: - Extension

extension AlertSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    // 每個cell 的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    // 每個header 的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 40
        case 1:
            return 20
        default:
            return 1
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
            label.text = "Note: Urgent low alert at 55 mg/dL is always on."
        default:
            label.text = ""
        }
        
        headerView.addSubview(label)
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
             return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvAlert.dequeueReusableCell(withIdentifier: AlertTableViewCell.identifier, for: indexPath) as! AlertTableViewCell
        cell.selectionStyle = .none
        switch indexPath.section {
        case 0:
            cell.lbTitle.text = titleArray[indexPath.row]
            if indexPath.row == 0 {
                if UserPreferences.shared.highAlert {
                    cell.lbContent.text = UserPreferences.shared.highLimit
                } else {
                    cell.lbContent.text = "none"
                }
            } else {
                if UserPreferences.shared.lowAlert {
                    cell.lbContent.text = UserPreferences.shared.lowLimit
                } else {
                    cell.lbContent.text = "none"
                }
            }
        case 1:
            cell.lbTitle.text = "Rate Alerts"
            if UserPreferences.shared.fallAlert || UserPreferences.shared.riseAlert {
                cell.lbContent.text = "On"
            } else {
                cell.lbContent.text = "Off"
            }
            
        default:
            cell.lbTitle.text = "Audio"
            if UserPreferences.shared.isOverride {
                cell.lbContent.text = UserPreferences.shared.bellSetting
            } else {
                cell.lbContent.text = "Overriden ringer for all alerts"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
               let highBloodVC = HighBloodAlertViewController()
               navigationController?.pushViewController(highBloodVC, animated: true)
            } else if indexPath.row == 1 {
                let lowBloodVC = LowBloodAlertViewController()
                navigationController?.pushViewController(lowBloodVC, animated: true)
            }
            
        case 1:
           let RateAlertVC = RateAlertViewController()
            navigationController?.pushViewController(RateAlertVC, animated: true)
        default:
            let AudioVC = AudioSettingViewController()
            navigationController?.pushViewController(AudioVC, animated: true)
        }
    }
}

// MARK: - Protocol


