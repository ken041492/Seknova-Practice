//
//  PersonalViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/2.
//

import UIKit

import RealmSwift

class PersonalViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tbvPersionalInfo: UITableView!
  
    @IBOutlet weak var vBirth: UIView!
    
    @IBOutlet weak var btnCancle: UIButton!
    
    @IBOutlet weak var btnFinish: UIButton!
    
    @IBOutlet weak var dpkBirth: UIDatePicker!
    
    // MARK: - Variables
    
    let persionalTitle: [String] = ["名", "姓", "出生日期", "電子信箱", "手機號碼", "地址"]
    
    let accountTitle: [String] = ["發射器裝置", "感測器裝置", "修改密碼"]
        
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
    

//    var Phone_Verified: Bool = false
    var userInfoArray: [UserInformationStruct] = []

    let realm = try! Realm()
        
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        setupData()
        print(UserPreferences.shared.userMail)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTableView),
                                               name: NotificationNames.infoDataUpdated,
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
        tbvPersionalInfo.register(UINib(nibName: "MailTableViewCell", bundle: nil), forCellReuseIdentifier: MailTableViewCell.identifier)
        
        tbvPersionalInfo.register(UINib(nibName: "PhoneTableViewCell", bundle: nil), forCellReuseIdentifier: PhoneTableViewCell.identifier)
        
        tbvPersionalInfo.register(UINib(nibName: "NameTableViewCell", bundle: nil), forCellReuseIdentifier: NameTableViewCell.identifier)
        
        tbvPersionalInfo.delegate = self
        tbvPersionalInfo.dataSource = self
        tbvPersionalInfo.sectionHeaderTopPadding = 5
        
        vBirth.isHidden = true
        // 获取当前日期
        let currentDate = Date()
        // 设置日期选择器的最大日期为今天（不包括今天）
        dpkBirth.maximumDate = currentDate
        dpkBirth.backgroundColor = .white
    }
    
    func setupNavigation() {
        
    }
    
    func setupData(){
        
        let realm = try! Realm()
        let infoData = realm.objects(UserInformation.self)
        storeFirstName = infoData[0].FirstName
        storeLastName = infoData[0].LastName
        storeBirth = infoData[0].BirthDay
//        storeMail = infoData[0].Email
        storeMail = UserPreferences.shared.userMail
        storePhoneNumber = "+886 \(infoData[0].Phone)"
        storeAddress = infoData[0].Address
        storeHeight = "\(infoData[0].Height)"
        storeWeight = "\(infoData[0].Weight)"
        
        selectGender = infoData[0].Gender
        selectRacism = infoData[0].Race
        selectDrink = infoData[0].Liquor
        if (infoData[0].Smoke) {
            selectSmoke = "有"
        } else {
            selectSmoke = "無"
        }
        print("======")
        print(infoData[0].Phone_Verified)
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
    @IBAction func cancle(_ sender: UIButton) {
        vBirth.isHidden = true
    }
    
    @IBAction func finish(_ sender: UIButton) {
        let realm = try! Realm()
        let infoData = realm.objects(UserInformation.self)
        if storeBirth == "" || storeBirth == infoData[0].BirthDay{
            let currentDate = Date()
            let calendar = Calendar.current
            let year = calendar.component(.year, from: currentDate)
            let month = calendar.component(.month, from: currentDate)
            let day = calendar.component(.day, from: currentDate)
            storeBirth = "\(year)-\(month)-\(day)"
        }
        tbvPersionalInfo.reloadData()
        vBirth.isHidden = true
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
    
    @objc func reloadTableView() {

        let realm = try! Realm()
        let infoData = realm.objects(UserInformation.self)
        try! realm.write {
            infoData[0].LastName = storeLastName
            infoData[0].FirstName = storeFirstName
            infoData[0].Height = Int(storeHeight)!
            infoData[0].Weight = Int(storeWeight)!
            infoData[0].Address = storeAddress

            infoData[0].Liquor = selectDrink
            if selectSmoke == "有" {
                infoData[0].Smoke = true
            } else {
                infoData[0].Smoke = false
            }
            infoData[0].BirthDay = storeBirth
            infoData[0].Gender = selectGender
            infoData[0].Race = selectRacism
        }
        tbvPersionalInfo.reloadData()
    }
    
}
// MARK: - Extension
extension PersonalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
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
        case 2:
            return "帳號"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1:
            return 6
        case 2:
            return 3
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 2 {

                let cell = tbvPersionalInfo.dequeueReusableCell(withIdentifier: MailTableViewCell.identifier, for: indexPath) as! MailTableViewCell
                //                cell.selectionStyle = .none
                cell.accessoryType = .none
                cell.lbContent.textAlignment = .right
                cell.lbContent.text = storeBirth
                cell.lbTitle.text = persionalTitle[indexPath.row]
                return cell
            } else if indexPath.row == 3 {
                
                let cell = tbvPersionalInfo.dequeueReusableCell(withIdentifier: MailTableViewCell.identifier, for: indexPath) as! MailTableViewCell
                cell.selectionStyle = .none
                cell.accessoryType = .none
                cell.lbContent.textAlignment = .right
                cell.lbTitle.text = persionalTitle[indexPath.row]
                storeMail = UserPreferences.shared.userMail
                cell.lbContent.text = storeMail
                
                return cell
            } else if indexPath.row == 4 {
                let cell = tbvPersionalInfo.dequeueReusableCell(withIdentifier: PhoneTableViewCell.identifier, for: indexPath) as! PhoneTableViewCell
                cell.lbTitle.text = persionalTitle[indexPath.row]
                cell.lbContent.text = storePhoneNumber
                cell.lbContent.textAlignment = .right
                
                cell.accessoryType = .none
                let realm = try! Realm()
                let infoData = realm.objects(UserInformation.self)
                if infoData[0].Phone_Verified {
                    cell.imgvVerified.image = resizeImage(image: UIImage(named: "phone_verified")!,
                                                          targetSize: CGSize(width: 20.0, height: 20.0))
                } else {
                    cell.imgvVerified.image = resizeImage(image: UIImage(named: "phone_alarm")!,
                                                          targetSize: CGSize(width: 20.0, height: 20.0))
                }
                return cell
            } else {
                let cell = tbvPersionalInfo.dequeueReusableCell(withIdentifier: NameTableViewCell.identifier, for: indexPath) as! NameTableViewCell
                cell.selectionStyle = .none
                cell.accessoryType = .none
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
                } else {
                    cell.txfInput.tag = 3
                    cell.txfInput.text = storeAddress
                    storeAddress = cell.txfInput.text!

                }
                return cell
            }
        case 1:
            if indexPath.row == 1 || indexPath.row == 2 {
                
                let cell = tbvPersionalInfo.dequeueReusableCell(withIdentifier: NameTableViewCell.identifier, for: indexPath) as! NameTableViewCell
                cell.selectionStyle = .none
                cell.accessoryType = .none

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
                let cell = tbvPersionalInfo.dequeueReusableCell(withIdentifier: MailTableViewCell.identifier, for: indexPath) as! MailTableViewCell
                cell.selectionStyle = .none
                cell.lbTitle.text = bodyTitle[indexPath.row]
                cell.lbContent.textAlignment = .right
                switch indexPath.row {
                case 0:
                    cell.lbContent.text = selectGender
                case 3:
                    cell.lbContent.text = selectRacism
                case 4:
                    cell.lbContent.text = selectDrink
                case 5:
                    cell.lbContent.text = selectSmoke
                default:
                    break
                }
                cell.accessoryType = .none
                return cell
            }
        case 2:
            let cell = tbvPersionalInfo.dequeueReusableCell(withIdentifier: MailTableViewCell.identifier, for: indexPath) as! MailTableViewCell
            cell.lbTitle.text = accountTitle[indexPath.row]
            if indexPath.row == 0 {
                cell.lbContent.text = UserPreferences.shared.deviceID
            } else if indexPath.row == 1{
                cell.lbContent.text = UserPreferences.shared.scaningID
            } else {
                cell.lbContent.text = ""
            }
            cell.accessoryType = .disclosureIndicator
            cell.lbContent.textAlignment = .right

//            cell.selectionStyle = .none
            return cell
        default:
            let cell = tbvPersionalInfo.dequeueReusableCell(withIdentifier: MailTableViewCell.identifier, for: indexPath) as! MailTableViewCell
            cell.lbTitle.text = ""
            cell.lbContent.text = "登出"
            cell.lbContent.textAlignment = .center

            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 2 {
                vBirth.isHidden = false
            } else if indexPath.row == 4 {
                let bindingPhoneVC = BindPhoneViewController()
                navigationController?.pushViewController(bindingPhoneVC, animated: true)
            }
        case 1:
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
        case 2:
            if indexPath.row == 0 {
                let transmitterVC = TransmitterViewController()
                transmitterVC.fromMainVc = true
                navigationController?.pushViewController(transmitterVC, animated: true)
            } else if indexPath.row == 1 {
                let scannerVC = ScannigSensorViewController()
                navigationController?.pushViewController(scannerVC, animated: true)
            } else if indexPath.row == 2 {
                let resetPwVC = ResetPasswordViewController()
                navigationController?.pushViewController(resetPwVC, animated: true)
            } else {
                return
            }
        default:
            navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension PersonalViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 4 || textField.tag == 5 {
            let length = string.lengthOfBytes(using: String.Encoding.utf8)
            for loopIndex in 0..<length {
                let char = (string as NSString).character(at: loopIndex)
                if char < 48 || char > 57 {
                    return false
                }
            }
        }
        return true
    }
}

// MARK: - Protocol



