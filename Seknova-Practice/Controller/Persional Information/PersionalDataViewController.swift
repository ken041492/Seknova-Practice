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
    
    @IBOutlet weak var nextBTN: UIButton!
    
    @IBOutlet weak var PersionalInfotableView: UITableView!
    
    @IBOutlet weak var birthView: UIView!
    
    @IBOutlet weak var cancleBTN: UIButton!
    
    @IBOutlet weak var finishBTN: UIButton!
    
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    // MARK: - Variables
    let persionalTitle: [String] = ["名", "姓", "出生日期", "電子信箱", "手機號碼", "地址"]
    let bodyTitle: [String] = ["性別", "身高", "體重", "種族", "飲酒", "抽菸"]
    let gender: [String] = ["生理男", "生理女"]
    let racism: [String] = ["亞洲", "非洲", "高加索", "拉丁", "其它"]
    let smoking: [String] = ["有", "無"]
    let drinking: [String] = ["無", "偶爾", "頻繁", "每天"]
    
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
        
        PersionalInfotableView.register(UINib(nibName: "PersonalInfoTableViewCell", bundle: nil), forCellReuseIdentifier: PersonalInfoTableViewCell.identifier)
        
        PersionalInfotableView.register(UINib(nibName: "PersionalMailTableViewCell", bundle: nil), forCellReuseIdentifier: PersionalMailTableViewCell.identifier)
        
        PersionalInfotableView.register(UINib(nibName: "PersionalBirthTableViewCell", bundle: nil), forCellReuseIdentifier: PersionalBirthTableViewCell.identifier)
        
        PersionalInfotableView.delegate = self
        PersionalInfotableView.dataSource = self
        PersionalInfotableView.sectionHeaderTopPadding = 5
        
        nextBTN.setTitle("下一步", for: .normal)
        birthView.isHidden = true
        // 获取当前日期
        let currentDate = Date()
        // 设置日期选择器的最大日期为今天（不包括今天）
        birthDatePicker.maximumDate = currentDate
        birthDatePicker.backgroundColor = .white
    }
    
    func setupNavigation() {
        title = "Persional Information"
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.backBarButtonItem = nil
    }

    // MARK: - IBAction
    @IBAction func cancle(_ sender: UIButton) {
        birthView.isHidden = true
    }
    
    @IBAction func finish(_ sender: UIButton) {
        if storeBirth == "" {
            let currentDate = Date()
            let calendar = Calendar.current
            let year = calendar.component(.year, from: currentDate)
            let month = calendar.component(.month, from: currentDate)
            let day = calendar.component(.day, from: currentDate)
            storeBirth = "\(year)-\(month)-\(day)"
        }
        PersionalInfotableView.reloadData()
        birthView.isHidden = true
    }
    
    @IBAction func selectBirth(_ sender: UIDatePicker) {
        
        let selectedDate: Date = sender.date
        let calendar = Calendar.current
        let year = calendar.component(.year, from: selectedDate)
        let month = calendar.component(.month, from: selectedDate)
        let day = calendar.component(.day, from: selectedDate)
        
        storeBirth = "\(year)-\(month)-\(day)"
        print(storeBirth)
    }
    
    @IBAction func goToNextVc(_ sender: Any) {

//        if storeBirth == "" || storeLastName == "" || storeFirstName == "" ||
//            storeHeight == "" || storeWeight == "" || selectDrink == "" ||
//            selectSmoke == "" || selectGender == "" || selectRacism == ""{
//
//            let controller = UIAlertController(title: "格式錯誤",
//                                               message: "除了地址及電話號碼其他欄位不得為空",
//                                               preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            controller.addAction(okAction)
//            present(controller, animated: true)
//        } else {
//            let realm = try! Realm()
////            let userInfo = realm.objects(UserInformation.self)
//            var storeSmoke: Bool = false
//            if selectSmoke == "有" {
//                storeSmoke = true
//            }
//            try! realm.write {
//                realm.add(UserInformation(FirstName: storeFirstName, LastName: storeLastName, BirthDay: storeBirth, Email: storeMail, Phone: storePhoneNumber, Address: storeAddress, Gender: selectGender, Height: Int(storeHeight)!, Weight: Int(storeWeight)!, Race: selectRacism, Liquor: selectDrink, Smoke: storeSmoke, Check: true, Phone_Verified: true))
//            }
//
//            print("file: \(realm.configuration.fileURL!)")
//            let TeachingVC = TeachingViewController()
//            navigationController?.pushViewController(TeachingVC, animated: true)
//        }
        
        let TeachingVC = TeachingViewController()
        navigationController?.pushViewController(TeachingVC, animated: true)
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
            textField.delegate = self
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
            textField.delegate = self
            storeHeight = textField.text!
        }
    }
    
    @objc func weightTextFieldChange(_ textField: UITextField) {
        if textField.tag == 5 {
            textField.delegate = self
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
            return "個人資訊"
        case 1:
            return "身體數值"
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
                
                let cell = PersionalInfotableView.dequeueReusableCell(withIdentifier: PersionalBirthTableViewCell.identifier, for: indexPath) as! PersionalBirthTableViewCell
                cell.selectLabel.text = storeBirth
                cell.titleLabel.text = persionalTitle[indexPath.row]
                return cell
            } else if indexPath.row == 3 {
                
                let cell = PersionalInfotableView.dequeueReusableCell(withIdentifier: PersionalMailTableViewCell.identifier, for: indexPath) as! PersionalMailTableViewCell
                cell.titleLabel.text = persionalTitle[indexPath.row]
                storeMail = UserPreferences.shared.userMail
                cell.mailLabel.text = storeMail
                
                return cell
            } else {
                
                let cell = PersionalInfotableView.dequeueReusableCell(withIdentifier: PersonalInfoTableViewCell.identifier, for: indexPath) as! PersonalInfoTableViewCell
                cell.titleLabel.text = persionalTitle[indexPath.row]
                if indexPath.row == 0 {
                    cell.inputTextField.tag = 0
                    cell.inputTextField.text = storeLastName
                    storeLastName = cell.inputTextField.text!
                    cell.inputTextField.addTarget(self, action: #selector(lastNameTextFieldChange(_:)), for: .editingChanged)
                } else if indexPath.row == 1 {
                    cell.inputTextField.tag = 1
                    cell.inputTextField.text = storeFirstName
                    storeFirstName = cell.inputTextField.text!
                    cell.inputTextField.addTarget(self, action: #selector(firstNameTextFieldChange(_:)), for: .editingChanged)
                } else if indexPath.row == 4 {
                    cell.inputTextField.tag = 2

//                    cell.inputTextField.delegate = self
                    cell.inputTextField.text = storePhoneNumber
                    storePhoneNumber = cell.inputTextField.text!
                    cell.inputTextField.addTarget(self, action: #selector(phoneNumberTextFieldChange(_:)), for: .editingChanged)
                } else {
                    cell.inputTextField.tag = 3
                    cell.inputTextField.text = storeAddress
                    storeAddress = cell.inputTextField.text!
                    cell.inputTextField.addTarget(self, action: #selector(addressTextFieldChange(_:)), for: .editingChanged)
                }
                return cell
            }
        default:
            if indexPath.row == 1 || indexPath.row == 2 {
                
                let cell = PersionalInfotableView.dequeueReusableCell(withIdentifier: PersonalInfoTableViewCell.identifier, for: indexPath) as! PersonalInfoTableViewCell
//                cell.inputTextField.delegate = self
                
                if indexPath.row == 1 {
                    cell.inputTextField.tag = 4

                    cell.titleLabel.text = bodyTitle[indexPath.row]
                    cell.inputTextField.text = "\(storeHeight)"
                    storeHeight = cell.inputTextField.text!
                    cell.inputTextField.addTarget(self, action: #selector(lengthTextFieldChange(_:)), for: .editingChanged)
                } else {
                    cell.inputTextField.tag = 5

                    cell.titleLabel.text = bodyTitle[indexPath.row]
                    cell.inputTextField.text = "\(storeWeight)"
                    storeWeight = cell.inputTextField.text!
                    cell.inputTextField.addTarget(self, action: #selector(weightTextFieldChange(_:)), for: .editingChanged)
                }
                return cell
            } else {
                let cell = PersionalInfotableView.dequeueReusableCell(withIdentifier: PersionalBirthTableViewCell.identifier, for: indexPath) as! PersionalBirthTableViewCell
                cell.titleLabel.text = bodyTitle[indexPath.row]
                switch indexPath.row {
                case 0:
                    cell.selectLabel.text = selectGender
                case 3:
                    cell.selectLabel.text = selectRacism
                case 4:
                    cell.selectLabel.text = selectDrink
                case 5:
                    cell.selectLabel.text = selectSmoke
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
                birthView.isHidden = false
            }
        default:
            switch indexPath.row {
            case 0:
                Alert().showActionSheet(titles: gender,
                                        cancelTitle: "取消",
                                        vc: self,
                                        action: { selectedTitle in
                    self.selectGender = selectedTitle
                    self.PersionalInfotableView.reloadData()
                })
            case 3:
                Alert().showActionSheet(titles: racism,
                                        cancelTitle: "取消",
                                        vc: self,
                                        action: { selectedTitle in
                    self.selectRacism = selectedTitle
                    self.PersionalInfotableView.reloadData()
                })
            case 4:
                Alert().showActionSheet(titles: drinking,
                                        cancelTitle: "取消",
                                        vc: self,
                                        action: { selectedTitle in
                    self.selectDrink = selectedTitle
                    self.PersionalInfotableView.reloadData()
                })
            case 5:
                Alert().showActionSheet(titles: smoking,
                                        cancelTitle: "取消",
                                        vc: self,
                                        action: { selectedTitle in
                    self.selectSmoke = selectedTitle
                    self.PersionalInfotableView.reloadData()
                })
            default:
                return
            }
        }
    }
}

extension PersionalDataViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        // 检查每个输入字符是否属于数字字符集
        for character in string {
            if !allowedCharacterSet.contains(character.unicodeScalars.first!) {
                // 如果输入字符不是数字字符，阻止输入
                return false
            }
        }
        return true
    }

}
// MARK: - Protocol



