//
//  SettingViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/16.
//

import UIKit

class SettingViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tbvSetting: UITableView!
    
    // MARK: - Variables
    
    var isCreative: Bool = false
    
    let titleArray = ["Alert Settings", "Unit Change", "Exceeding high and low blood sugar warning",
                      "Data Sync", "Warm-up state", "Upload Event Log", "Firmware Version", "App Version"]
    
    let creativeTitleArray = ["Alert Settings", "Calibration Mode", "Set Data initial value", "Set X-axis Time Interval (per/s)", "Set y-axis upper and lower limits",
                              "Unit Change", "Display Value Information", "Display RSSI", "Upload to the cloud", "Exceeding high and low blood sugar warning",
                              "Data Sync", "Warm-up state", "Upload Event Log", "Firmware Version", "App Version"]

    let contentArray = ["06/24 12:41:18", "1.24.9", "00.00.61"]
    
    var storeADCInitValue: String = ""
    
    var storeXaxisValue: String = ""
    
    var storeYaxisValue: String = ""
   
    var hasEnteredComma = false
    
    var storeUnitChange: Bool = false
    
    var storeIndicateData: Bool = false
    
    var storeIndicateRSSI: Bool = false
    
    var storeUploadCloud: Bool = false
    
    var storeOverflowAlert: Bool = false

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
        tbvSetting.register(UINib(nibName: "HaveImageTableViewCell", bundle: nil),
                            forCellReuseIdentifier: HaveImageTableViewCell.identifier)
        
        tbvSetting.register(UINib(nibName: "HaveSwitchTableViewCell", bundle: nil),
                            forCellReuseIdentifier: HaveSwitchTableViewCell.identifier)
        
        tbvSetting.register(UINib(nibName: "HaveLabelTableViewCell", bundle: nil),
                            forCellReuseIdentifier: HaveLabelTableViewCell.identifier)
       
        tbvSetting.register(UINib(nibName: "HaveTextfieldTableViewCell", bundle: nil),
                            forCellReuseIdentifier: HaveTextfieldTableViewCell.identifier)
        tbvSetting.register(UINib(nibName: "xAxisTableViewCell", bundle: nil), forCellReuseIdentifier: xAxisTableViewCell.identifier)
        
        tbvSetting.dataSource = self
        tbvSetting.delegate = self
        
        storeXaxisValue = UserPreferences.shared.xAxisValue
        storeYaxisValue = UserPreferences.shared.yAxisValue
        storeADCInitValue = "\(0)"
        
        storeIndicateData = UserPreferences.shared.indicateData
        storeUnitChange = UserPreferences.shared.unitChange
        storeIndicateRSSI = UserPreferences.shared.indicateRSSI
        storeUploadCloud = UserPreferences.shared.uploadCloud
        storeOverflowAlert = UserPreferences.shared.overflowAlert
    }
    
    func setupNavigation() {
        title = NSLocalizedString("SetPlan", comment: "")
        let backButton = UIBarButtonItem()
        backButton.title = NSLocalizedString("Return", comment: "")
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
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
    // MARK: - IBAction
    @objc func adcInitTextFieldChange(_ textField: UITextField) {
        if let text = textField.text, textField.tag == 1, text != ""{
            storeADCInitValue = text
            UserPreferences.shared.adcInitValue = Int(storeADCInitValue)!
        }
    }
    
    @objc func xAxisTextFieldChange(_ textField: UITextField) {
        if let text = textField.text, textField.tag == 2, text != ""{
            storeXaxisValue = text
            UserPreferences.shared.xAxisValue = storeXaxisValue
        }
    }
    
    @objc func yAxisTextFieldChange(_ textField: UITextField) {
        if let text = textField.text, textField.tag == 3, text != "" {
            storeYaxisValue = text
            UserPreferences.shared.yAxisValue = storeYaxisValue
        }
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
        switch sender.tag {
        case 1:
            storeUnitChange = sender.isOn
            UserPreferences.shared.unitChange = storeUnitChange
        case 2:
            storeOverflowAlert = sender.isOn
            UserPreferences.shared.overflowAlert = storeOverflowAlert
        case 3:
            storeIndicateData = sender.isOn
            UserPreferences.shared.indicateData = storeIndicateData
        case 4:
            storeIndicateRSSI = sender.isOn
            UserPreferences.shared.indicateRSSI = storeIndicateRSSI
        default:
            storeUploadCloud = sender.isOn
            UserPreferences.shared.uploadCloud = storeUploadCloud
        }
    }
}
// MARK: - Extension

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UserPreferences.shared.developStatus == "0000" {
            return 8
        } else {
            return 15
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if UserPreferences.shared.developStatus == "0000" {
            switch indexPath.row {
            case 0, 3:
                let imageCell = tbvSetting.dequeueReusableCell(withIdentifier: HaveImageTableViewCell.identifier, for: indexPath) as! HaveImageTableViewCell
                imageCell.lbTitle.text = NSLocalizedString("\(titleArray[indexPath.row])",
                                                           comment: "")
                if indexPath.row == 0 {
                    imageCell.imgvIcon.image = resizeImage(image: UIImage(named: "ArrowRight")!, targetSize: CGSize(width: 20, height: 20))
                } else {
                    imageCell.imgvIcon.image = resizeImage(image: UIImage(named: "reload")!, targetSize: CGSize(width: 20, height: 20))
                }
                
                imageCell.selectionStyle = .none
                return imageCell
            case 1, 2:
                let switchCell = tbvSetting.dequeueReusableCell(withIdentifier:
                                                                HaveSwitchTableViewCell.identifier,
                                                                for: indexPath) as! HaveSwitchTableViewCell
                switchCell.switchChange.addTarget(self,
                                            action: #selector(switchChanged),
                                            for: .valueChanged)
                if indexPath.row == 1 {
                    switchCell.switchChange.tag = 1
                    switchCell.switchChange.isOn = UserPreferences.shared.unitChange
                } else {
                    switchCell.switchChange.tag = 2
                    switchCell.switchChange.isOn = UserPreferences.shared.overflowAlert
                }
                switchCell.lbTitle.text = NSLocalizedString("\(titleArray[indexPath.row])",
                                                            comment: "")
                switchCell.selectionStyle = .none
                return switchCell
            default:
                let labelCell = tbvSetting.dequeueReusableCell(withIdentifier: HaveLabelTableViewCell.identifier, for: indexPath) as! HaveLabelTableViewCell
                labelCell.lbTitle.text = NSLocalizedString("\(titleArray[indexPath.row])",
                                                           comment: "")
                if indexPath.row == 4 {
                    labelCell.lbContent.text = "off"
                } else {
                    labelCell.lbContent.text = contentArray[indexPath.row - 5]
                }
                labelCell.selectionStyle = .none
                return labelCell
            }
        } else {
            switch indexPath.row {
            case 0, 1, 10 :
                let imageCell = tbvSetting.dequeueReusableCell(withIdentifier: HaveImageTableViewCell.identifier, for: indexPath) as! HaveImageTableViewCell
                imageCell.lbTitle.text = NSLocalizedString("\(creativeTitleArray[indexPath.row])",
                                                           comment: "")
                if indexPath.row == 10 {
                    imageCell.imgvIcon.image = resizeImage(image: UIImage(named: "reload")!, targetSize: CGSize(width: 20, height: 20))
                } else {
                    imageCell.imgvIcon.image = resizeImage(image: UIImage(named: "ArrowRight")!, targetSize: CGSize(width: 20, height: 20))
                }
                
                imageCell.selectionStyle = .none
                return imageCell
            case 2, 4:
                let textfieldCell = tbvSetting.dequeueReusableCell(withIdentifier: HaveTextfieldTableViewCell.identifier, for: indexPath) as! HaveTextfieldTableViewCell
                textfieldCell.txfInput.delegate = self
                textfieldCell.lbTitle.text = NSLocalizedString("\(creativeTitleArray[indexPath.row])",
                                                               comment: "")
                if indexPath.row == 2 {
                    textfieldCell.txfInput.tag = 1
                    textfieldCell.txfInput.text = storeADCInitValue
                    storeADCInitValue =                     textfieldCell.txfInput.text!
                        textfieldCell.txfInput.addTarget(self, action: #selector(adcInitTextFieldChange(_:)), for: .editingChanged)
                } else {
                    textfieldCell.txfInput.tag = 3
                    textfieldCell.txfInput.text = storeYaxisValue
                    storeYaxisValue = textfieldCell.txfInput.text!
                        textfieldCell.txfInput.addTarget(self, action: #selector(yAxisTextFieldChange(_:)), for: .editingChanged)
                }
                
                textfieldCell.selectionStyle = .none
                return textfieldCell
            case 3:
                let axisCell = tbvSetting.dequeueReusableCell(withIdentifier: xAxisTableViewCell.identifier, for: indexPath) as! xAxisTableViewCell
                axisCell.txfInput.delegate = self
                axisCell.lbTitle.text = NSLocalizedString("Set X axis time interval (per/s)", comment: "")
                axisCell.txfInput.tag = 2
                axisCell.txfInput.text = storeXaxisValue
                storeXaxisValue = axisCell.txfInput.text!
                axisCell.lbUnit.text = "per/s"
                axisCell.txfInput.addTarget(self, action: #selector(xAxisTextFieldChange(_:)), for: .editingChanged)
                return axisCell
            case 5, 6, 7, 8, 9 :
                let switchCell = tbvSetting.dequeueReusableCell(withIdentifier:
                                                                HaveSwitchTableViewCell.identifier,
                                                                for: indexPath) as! HaveSwitchTableViewCell
                switchCell.switchChange.addTarget(self,
                                            action: #selector(switchChanged),
                                            for: .valueChanged)
                if indexPath.row == 5 {
                    switchCell.switchChange.tag = 1
                    switchCell.switchChange.isOn = UserPreferences.shared.unitChange
                } else if indexPath.row == 9 {
                    switchCell.switchChange.tag = 2
                    switchCell.switchChange.isOn = UserPreferences.shared.overflowAlert
                } else if indexPath.row == 6 {
                    switchCell.switchChange.tag = 3
                    switchCell.switchChange.isOn = UserPreferences.shared.indicateData
                } else if indexPath.row == 7 {
                    switchCell.switchChange.tag = 4
                    switchCell.switchChange.isOn = UserPreferences.shared.indicateRSSI
                } else {
                    switchCell.switchChange.tag = 5
                    switchCell.switchChange.isOn = UserPreferences.shared.uploadCloud
                }
                switchCell.lbTitle.text = NSLocalizedString("\(creativeTitleArray[indexPath.row])",
                                                            comment: "")
                
                switchCell.selectionStyle = .none
                return switchCell
            default:
                let labelCell = tbvSetting.dequeueReusableCell(withIdentifier: HaveLabelTableViewCell.identifier, for: indexPath) as! HaveLabelTableViewCell
                labelCell.lbTitle.text = NSLocalizedString("\(creativeTitleArray[indexPath.row])",
                                                           comment: "")
                if indexPath.row == 11 {
                    labelCell.lbContent.text = "On"
                } else {
                    labelCell.lbContent.text = contentArray[indexPath.row - 12]
                }
                
                labelCell.selectionStyle = .none
                return labelCell
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if UserPreferences.shared.developStatus == "0000" {
            if indexPath.row == 0{
                let alertSettingVC = AlertSettingViewController()
                navigationController?.pushViewController(alertSettingVC, animated: true)
            }
            if indexPath.row == 4 {
                Alert().showDeviceIDInputAlert(vc: self,
                                               title: NSLocalizedString("Please enter the corresponding string!", comment: ""),
                                               message: NSLocalizedString("Please enter 0000 to switch to warm state\nor enter 8888 to enable development mode", comment: ""),
                                               placeholder: "",
                                               onConfirm: { [self] deviceID in
                    let isInputValid = deviceID.count == 4 &&
                        deviceID.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil

                    if isInputValid {
//                        print("用户输入的设备ID是：\(deviceID)")
                        if deviceID == "0000" {
                            UserPreferences.shared.developStatus = deviceID
                        } else if deviceID == "8888"{
                            UserPreferences.shared.developStatus = deviceID
                        } else {
                            Alert().showAlert(title: NSLocalizedString("Please enter the corresponding string!", comment: ""),
                                              message: NSLocalizedString("Please enter 0000 to switch to warm state\nor enter 8888 to enable development mode", comment: ""),
                                              vc: self)
                        }
                        tbvSetting.reloadData()
                    } else {
                        Alert().showAlert(title: NSLocalizedString("Please enter the corresponding string!", comment: ""),
                                          message: NSLocalizedString("Please enter 0000 to switch to warm state\nor enter 8888 to enable development mode", comment: ""),
                                          vc: self)
                    }
                })
            }
        } else {
            if indexPath.row == 0{
                let alertSettingVC = AlertSettingViewController()
                navigationController?.pushViewController(alertSettingVC, animated: true)
            } else if indexPath.row == 1 {
               let correctModeVC = CorrectModeViewController()
                navigationController?.pushViewController(correctModeVC, animated: true)
            } else if indexPath.row == 11 {
                Alert().showDeviceIDInputAlert(vc: self,
                                               title: NSLocalizedString("Please enter the corresponding string!", comment: ""),
                                               message: NSLocalizedString("Please enter 0000 to switch to warm state\nor enter 8888 to enable development mode", comment: ""),
                                               placeholder: "",
                                               onConfirm: { [self] deviceID in
                    //            print("用户输入的设备ID是：\(deviceID)")
                    let isInputValid = deviceID.count == 4 &&
                    deviceID.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
                    
                    if isInputValid {
                        //                        print("用户输入的设备ID是：\(deviceID)")
                        if deviceID == "0000" {
                            UserPreferences.shared.developStatus = deviceID
                        } else if deviceID == "8888"{
                            UserPreferences.shared.developStatus = deviceID
                        } else {
                            Alert().showAlert(title: NSLocalizedString("Please enter the corresponding string!", comment: ""),
                                              message: NSLocalizedString("Please enter 0000 to switch to warm state\nor enter 8888 to enable development mode", comment: ""),
                                              vc: self)
                        }
                        tbvSetting.reloadData()
                    } else {
                        Alert().showAlert(title: NSLocalizedString("Please enter the corresponding string!", comment: ""),
                                          message: NSLocalizedString("Please enter 0000 to switch to warm state\nor enter 8888 to enable development mode", comment: ""),
                                          vc: self)
                    }
                })
            }
        }
    }
}

extension SettingViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 3 {
            // 检查用户是否已经输入过逗号
            // 先检查 textField 中是否已经存在逗号，如果没有，将 hasEnteredComma 设置为 false
            if !textField.text!.contains(",") {
                hasEnteredComma = false
            }
            
            if hasEnteredComma {
                // 如果已经输入过逗号，阻止用户输入逗号
                if string == "," {
                    return false
                }
            } else {
                // 如果用户尚未输入逗号，检查字符是否是数字或逗号
                let allowedCharacterSet = CharacterSet(charactersIn: "0123456789,")
                let stringCharacterSet = CharacterSet(charactersIn: string)

                if !allowedCharacterSet.isSuperset(of: stringCharacterSet) {
                    return false // 阻止用户输入不允许的字符
                }
                // 如果用户输入的字符是逗号，标记为已输入逗号
                if string == "," {
                    hasEnteredComma = true
                }
            }

            return true // 允许输入
        } else {
            let length = string.lengthOfBytes(using: String.Encoding.utf8)
            for loopIndex in 0..<length {
                let char = (string as NSString).character(at: loopIndex)
                if char < 48 || char > 57 {
                    return false
                }
            }
            return true
        }
    }
}
// MARK: - Protocol


