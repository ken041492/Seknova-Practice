//
//  PersionalDataViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/16.
//

import UIKit

import RealmSwift

class PersionalDataViewController: UIViewController {
    
    // MARK: - IBOutlet
    
//    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var tbvPersionalInfo: UITableView!
    
    @IBOutlet weak var vBirth: UIView!
    
    @IBOutlet weak var btnCancle: UIButton!
    
    @IBOutlet weak var btnFinish: UIButton!
    
    @IBOutlet weak var dpkBirth: UIDatePicker!
    
    // MARK: - Variables
//    let persionalTitle: [String] = ["名", "姓", "出生日期", "電子信箱", "手機號碼", "地址"]
//    let bodyTitle: [String] = ["性別", "身高", "體重", "種族", "飲酒", "抽菸"]
//    let gender: [String] = ["生理男", "生理女"]
//    let racism: [String] = ["亞洲", "非洲", "高加索", "拉丁", "其它"]
//    let smoking: [String] = ["有", "無"]
//    let drinking: [String] = ["無", "偶爾", "頻繁", "每天"]
    
    let persionalTitle: [String] = ["FirstName", "LastName", "Birthday", "Email", "Phone", "Address"]
    let bodyTitle: [String] = ["Gender", "Height", "Weight", "Race", "Liquor", "Smoke"]
    let gender: [String] = ["Male", "Female"]
    let racism: [String] = ["Asia", "Africa", "Caucasus", "Latin", "Other"]
    let smoking: [String] = ["Yes", "No"]
    let drinking: [String] = ["None", "Occasionally", "Frequently", "Everyday"]
    
    var selectGender: String = ""
    var selectDrink: String = ""
    var selectRacism: String = ""
    var selectSmoke: String = ""
    
    var storeBirth: String = ""
    var storeMail: String = ""
    var storeLastName: String = ""
    var storeFirstName: String = ""
    var storePhoneNumber: String = ""
    var storeAddress: String = ""
    var storeHeight: String = ""
    var storeWeight: String = ""
    
    var userInfoArray: [UserInformationStruct] = []
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
        
        tbvPersionalInfo.register(UINib(nibName: "PersonalInfoTableViewCell", bundle: nil), forCellReuseIdentifier: PersonalInfoTableViewCell.identifier)
        
        tbvPersionalInfo.register(UINib(nibName: "PersionalMailTableViewCell", bundle: nil), forCellReuseIdentifier: PersionalMailTableViewCell.identifier)
        
        tbvPersionalInfo.register(UINib(nibName: "PersionalBirthTableViewCell", bundle: nil), forCellReuseIdentifier: PersionalBirthTableViewCell.identifier)
        
        tbvPersionalInfo.delegate = self
        tbvPersionalInfo.dataSource = self
        tbvPersionalInfo.sectionHeaderTopPadding = 5
        
        btnNext.setTitle(NSLocalizedString("Next", comment: ""), for: .normal)
        vBirth.isHidden = true
        // 获取当前日期
        let currentDate = Date()
        // 设置日期选择器的最大日期为今天（不包括今天）
        dpkBirth.maximumDate = currentDate
        dpkBirth.backgroundColor = .white
    }
    
    func setupNavigation() {
        title = "Persional Information"
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.backBarButtonItem = nil
    }

    // MARK: - IBAction
    @IBAction func cancle(_ sender: UIButton) {
        vBirth.isHidden = true
    }
    
    @IBAction func finish(_ sender: UIButton) {
        if storeBirth == "" {
            let currentDate = Date()
            let calendar = Calendar.current
            let year = calendar.component(.year, from: currentDate)
            let month = calendar.component(.month, from: currentDate)
            let day = calendar.component(.day, from: currentDate)
            if month < 10 {
                storeBirth = "\(year)-0\(month)-\(day)"
            } else {
                storeBirth = "\(year)-\(month)-\(day)"
            }
        }
        tbvPersionalInfo.reloadData()
        vBirth.isHidden = true
        btnNext.isHidden = false
    }
    
    @IBAction func selectBirth(_ sender: UIDatePicker) {
        
        let selectedDate: Date = sender.date
        let calendar = Calendar.current
        let year = calendar.component(.year, from: selectedDate)
        let month = calendar.component(.month, from: selectedDate)
        let day = calendar.component(.day, from: selectedDate)
       
        if month < 10 {
            storeBirth = "\(year)-0\(month)-\(day)"
        } else {
            storeBirth = "\(year)-\(month)-\(day)"
        }
    }
    
    @IBAction func goToNextVc(_ sender: Any) {

        if storeBirth == "" || storeLastName == "" || storeFirstName == "" ||
            storeHeight == "" || storeWeight == "" || selectDrink == "" ||
            selectSmoke == "" || selectGender == "" || selectRacism == ""{

            Alert().showAlert(title: "格式錯誤",
                              message: "除了地址及電話號碼其他欄位不得為空",
                              vc: self)
        } else {
            let realm = try! Realm()
            var storeSmoke: Bool = false
            if selectSmoke == "有" {
                storeSmoke = true
            }
            try! realm.write {
                realm.add(UserInformation(FirstName: storeFirstName, LastName: storeLastName, BirthDay: storeBirth, Email: storeMail, Phone: storePhoneNumber, Address: storeAddress, Gender: selectGender, Height: Int(storeHeight)!, Weight: Int(storeWeight)!, Race: selectRacism, Liquor: selectDrink, Smoke: storeSmoke, Check: true, Phone_Verified: false))
            }

            print("file: \(realm.configuration.fileURL!)")
            let TeachingVC = TeachingViewController()
            navigationController?.pushViewController(TeachingVC, animated: true)
        }
    }
    
    @objc func lastNameTextFieldChange(_ textField: UITextField) {
        if textField.tag == 0 {
            storeLastName = textField.text!
        }
    }
    
    @objc func firstNameTextFieldChange(_ textField: UITextField) {
        if textField.tag == 1 {
            storeFirstName = textField.text!
        }
    }
    
    @objc func phoneNumberTextFieldChange(_ textField: UITextField) {
        if textField.tag == 2 {
            storePhoneNumber = textField.text!
        }
    }
    
    @objc func addressTextFieldChange(_ textField: UITextField) {
        if textField.tag == 3 {
            storeAddress = textField.text!
        }
    }
    
    @objc func lengthTextFieldChange(_ textField: UITextField) {
        if textField.tag == 4 {
            storeHeight = textField.text!
        }
    }
    
    @objc func weightTextFieldChange(_ textField: UITextField) {
        if textField.tag == 5 {
            storeWeight = textField.text!
        }
    }
}
// MARK: - Extension
extension PersionalDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    // 每個cell 的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    // 每個header 的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return NSLocalizedString("Personal information", comment: "")
        case 1:
            return NSLocalizedString("Body value", comment: "")
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 2 {
                
                let cell = tbvPersionalInfo.dequeueReusableCell(withIdentifier: PersionalBirthTableViewCell.identifier, for: indexPath) as! PersionalBirthTableViewCell
                cell.selectionStyle = .none
                cell.lbSelect.text = storeBirth
                cell.lbTitle.text = NSLocalizedString("\(persionalTitle[indexPath.row])", comment: "")
                return cell
            } else if indexPath.row == 3 {
                
                let cell = tbvPersionalInfo.dequeueReusableCell(withIdentifier: PersionalMailTableViewCell.identifier, for: indexPath) as! PersionalMailTableViewCell
                cell.selectionStyle = .none
                cell.lbTitle.text = persionalTitle[indexPath.row]
                storeMail = UserPreferences.shared.userMail
                cell.lbMail.text = storeMail
                
                return cell
            } else {
                
                let cell = tbvPersionalInfo.dequeueReusableCell(withIdentifier: PersonalInfoTableViewCell.identifier, for: indexPath) as! PersonalInfoTableViewCell
                cell.selectionStyle = .none
                cell.lbTitle.text = persionalTitle[indexPath.row]
                if indexPath.row == 0 {
                    cell.txfInput.tag = 0
                    cell.txfInput.text = storeLastName
                    storeLastName = cell.txfInput.text!
                    cell.txfInput.addTarget(self, action: #selector(lastNameTextFieldChange(_:)), for: .editingChanged)
                } else if indexPath.row == 1 {
                    cell.txfInput.tag = 1
                    cell.txfInput.text = storeFirstName
                    storeFirstName = cell.txfInput.text!
                    cell.txfInput.addTarget(self, action: #selector(firstNameTextFieldChange(_:)), for: .editingChanged)
                } else if indexPath.row == 4 {
                    cell.txfInput.tag = 2
                    
                    if cell.txfInput.tag == 2 {cell.txfInput.delegate = self}
                    cell.txfInput.text = storePhoneNumber
                    storePhoneNumber = cell.txfInput.text!
                    cell.txfInput.addTarget(self, action: #selector(phoneNumberTextFieldChange(_:)), for: .editingChanged)
                } else {
                    cell.txfInput.tag = 3
                    cell.txfInput.text = storeAddress
                    storeAddress = cell.txfInput.text!
                    cell.txfInput.addTarget(self, action: #selector(addressTextFieldChange(_:)), for: .editingChanged)
                }
                return cell
            }
        default:
            if indexPath.row == 1 || indexPath.row == 2 {
                
                let cell = tbvPersionalInfo.dequeueReusableCell(withIdentifier: PersonalInfoTableViewCell.identifier, for: indexPath) as! PersonalInfoTableViewCell
                cell.selectionStyle = .none
                if indexPath.row == 1 {
                    cell.txfInput.tag = 4
                    if cell.txfInput.tag == 4 {cell.txfInput.delegate = self}
                    cell.lbTitle.text = bodyTitle[indexPath.row]
                    cell.txfInput.text = "\(storeHeight)"
                    storeHeight = cell.txfInput.text!
                    cell.txfInput.addTarget(self, action: #selector(lengthTextFieldChange(_:)), for: .editingChanged)
                } else {
                    cell.txfInput.tag = 5
                    if cell.txfInput.tag == 5 {cell.txfInput.delegate = self}
                    cell.lbTitle.text = bodyTitle[indexPath.row]
                    cell.txfInput.text = "\(storeWeight)"
                    storeWeight = cell.txfInput.text!
                    cell.txfInput.addTarget(self, action: #selector(weightTextFieldChange(_:)), for: .editingChanged)
                }
                return cell
            } else {
                let cell = tbvPersionalInfo.dequeueReusableCell(withIdentifier: PersionalBirthTableViewCell.identifier, for: indexPath) as! PersionalBirthTableViewCell
                cell.selectionStyle = .none
                cell.lbTitle.text = bodyTitle[indexPath.row]
                switch indexPath.row {
                case 0:
                    cell.lbSelect.text = selectGender
                case 3:
                    cell.lbSelect.text = selectRacism
                case 4:
                    cell.lbSelect.text = selectDrink
                case 5:
                    cell.lbSelect.text = selectSmoke
                default:
                    break
                }
                return cell
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 2 {
                vBirth.isHidden = false
                btnNext.isHidden = true
            }
        default:
            switch indexPath.row {
            case 0:
                Alert().showActionSheet(titles: gender,
                                        cancelTitle: "取消",
                                        vc: self,
                                        action: { selectedTitle in
                    self.selectGender = selectedTitle
                    self.tbvPersionalInfo.reloadData()
                })
            case 3:
                Alert().showActionSheet(titles: racism,
                                        cancelTitle: "取消",
                                        vc: self,
                                        action: { selectedTitle in
                    self.selectRacism = selectedTitle
                    self.tbvPersionalInfo.reloadData()
                })
            case 4:
                Alert().showActionSheet(titles: drinking,
                                        cancelTitle: "取消",
                                        vc: self,
                                        action: { selectedTitle in
                    self.selectDrink = selectedTitle
                    self.tbvPersionalInfo.reloadData()
                })
            case 5:
                Alert().showActionSheet(titles: smoking,
                                        cancelTitle: "取消",
                                        vc: self,
                                        action: { selectedTitle in
                    self.selectSmoke = selectedTitle
                    self.tbvPersionalInfo.reloadData()
                })
            default:
                return
            }
        }
    }
}

extension PersionalDataViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 2 || textField.tag == 4 || textField.tag == 5 {
            let length = string.lengthOfBytes(using: String.Encoding.utf8)
            for loopIndex in 0..<length {
                let char = (string as NSString).character(at: loopIndex)
                if char < 48 || char > 57 {
                    return false
                }
            }
            return true
        }
        return true
    }
}
// MARK: - Protocol



