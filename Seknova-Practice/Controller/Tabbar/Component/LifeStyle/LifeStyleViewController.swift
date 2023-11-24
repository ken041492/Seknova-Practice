//
//  LifeStyleViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/2.
//

import UIKit

import RealmSwift

class LifeStyleViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tbvRecord: UITableView!
    
    @IBOutlet weak var vContainer: UIView!
    
    @IBOutlet weak var btnCancle: UIButton!
    
    @IBOutlet weak var btnFinish: UIButton!
    
    @IBOutlet weak var dpkDate: UIDatePicker!
    
    @IBOutlet weak var btnAdd: UIButton!
   
    @IBOutlet weak var cvAction: UICollectionView!
    
    @IBOutlet weak var vCvTypeBackground: UIView!
   
    @IBOutlet weak var vCvShadow: UIView!
    
    @IBOutlet weak var cvType: UICollectionView!
    
    @IBOutlet weak var tbvInput: UITableView!
    
    @IBOutlet weak var vTimeBackground: UIView!
    
    @IBOutlet weak var pkvTimer: UIPickerView!
    
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!
    // MARK: - Variables

    let titleArray: [String] = ["Dining", "Exercise", "Sleeping", "Insulin", "Get up", "Bath", "Others"]

    let typeEatArray: [String] = ["Breakfast", "Lunch", "Dinner", "Snack", "Drinks"]

    let typexerciseArray: [String] = ["High Intensity", "Medium Intensity", "Low Intensity"]
    
    let typeSleepArray: [String] = ["Sleep", "Nap", "Rest", "Relax time"]
    
    let typeInsulinArray: [String] = ["Rapid acting", "Long acting", "Unspecified"]

    
    let imgvArray: [String] = ["meal", "exercise", "sleep", "insulin", "awaken", "bath", "other"]
    
    let imgvEatArray: [String] = ["breakfast", "lunch", "dinner", "snacks", "drinks"]
    
    let imgvExerciseArray: [String] = ["high_motion", "mid_motion", "low_motion"]
    
    let imgvSleepArray: [String] = ["sleep", "sleepy", "nap", "relax"]
   
    let imgvInsulin: String = "insulin"
    
    let eatTitleArray: [String] = ["Meal Name", "Quantity", "Note"]
    
    let exerciseTitleArray: [String] = ["Exercise Type", "During Time", "Note"]
    
    let sleepTitleArray: [String] = ["During Time", "Note"]
    
    let insulinTitleArray: [String] = ["Dose", "Note"]
    
    
    let ContentArray: [[String]] = [["Meal Name:", "Quantity:", "Note:"],
                                    ["Exercise Type:", "During Time:", "Note:"],
                                    ["During Time:", "Note:"],
                                    ["Dose:", "Note:"]]
    
    var eatingItem: String = ""
    
    var eatingQuantity: String = ""
    
    var exerciseType: String = ""
    
    var insulinQuantity: String = ""
    
    var mark: String = ""
    
    var selectDate: String = ""
    
    var storeDate: String = ""

    var selectType: Int = 0

    var clickTpyeIndexPath: Int = -1
    
    var clickCount = 0
    
    var clickTypeCount = 0
    
    let hours = [Int](0...23)
    
    let minutes = [Int](0...59)
    
    var selectHour: String = "00"
    
    var selectminute: String = "30"
    
    var initialHourIndex: Int = 0
    var initialMinuteIndex: Int = 0
    var selectActionIndex: Int = -1
    var selectTypeIndex: Int = -1
    
    var recordActionIndex: Int = -1
    var recordTypeIndex: Int = -1
    var registSelect = -1

    var isViewShifted: Bool = false
    var isToEdit: Bool = false
    var isEdit: Bool = false
    
    var selectedActionIndexPath: IndexPath?
    var selectedTypeIndexPath: IndexPath?
    var cvTypelayout: UICollectionViewFlowLayout!
    var lbPlaceHold: UILabel = UILabel()
    var editEvent: Event?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        setupediting()

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
        
        tbvRecord.register(UINib(nibName: "RecordTableViewCell", bundle: nil),
                           forCellReuseIdentifier: RecordTableViewCell.identifier)
        
        tbvInput.register(UINib(nibName: "NameTableViewCell", bundle: nil),
                          forCellReuseIdentifier: NameTableViewCell.identifier)
       
        tbvInput.register(UINib(nibName: "tbvTextViewCell", bundle: nil),
                          forCellReuseIdentifier: tbvTextViewCell.identifier)
        
        tbvInput.register(UINib(nibName: "MailTableViewCell", bundle: nil),
                          forCellReuseIdentifier: MailTableViewCell.identifier)
       
        tbvInput.register(UINib(nibName: "txfLbCell", bundle: nil),
                          forCellReuseIdentifier: txfLbCell.identifier)
        
        cvAction.register(UINib(nibName: "cvActionCell", bundle: nil),
                          forCellWithReuseIdentifier: cvActionCell.identifier)
        
        cvType.register(UINib(nibName: "cvTypeCell", bundle: nil),
                          forCellWithReuseIdentifier: cvTypeCell.identifier)
        
        tbvInput.addObserver(self, forKeyPath: "contentSize",
                             options: NSKeyValueObservingOptions.new,
                             context: nil)

        tbvRecord.delegate = self
        tbvRecord.dataSource = self
        tbvInput.delegate = self
        tbvInput.dataSource = self
        cvAction.delegate = self
        cvAction.dataSource = self
        cvType.delegate = self
        cvType.dataSource = self
        pkvTimer.delegate = self
        pkvTimer.dataSource = self
       
        tbvRecord.tag = 1
        tbvInput.tag = 2
        cvAction.tag = 1
        cvType.tag = 2

        cvType.isHidden = true
        vCvTypeBackground.isHidden = true
        tbvInput.isHidden = true
        vTimeBackground.isHidden = true
        
        if isEdit {
            btnAdd.setTitle(NSLocalizedString("Edit", comment: ""), for: .normal)
        } else {
            btnAdd.setTitle(NSLocalizedString("Insert", comment: ""), for: .normal)
        }
       
        dpkDate.maximumDate = Date()
        // 設定cvAction約束
        let cvActionlayout = UICollectionViewFlowLayout()
        cvActionlayout.scrollDirection = .horizontal
        cvActionlayout.itemSize = CGSize(width: 60, height: 128) // 设置宽度和高度
        // 设置collectionView的布局
        cvAction.collectionViewLayout = cvActionlayout
        cvAction.showsHorizontalScrollIndicator = false
        // 設定cvType約束
        cvTypelayout = UICollectionViewFlowLayout()
        cvTypelayout.scrollDirection = .horizontal
        cvTypelayout.itemSize = CGSize(width: 69, height: 120) // 设置宽度和高度
        cvTypelayout.minimumLineSpacing = 2
        // 设置collectionView的布局
        cvType.collectionViewLayout = cvTypelayout
        cvType.isScrollEnabled = false
        vContainer.isHidden = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.dateFormat = "yyyy/MM/dd EEEE a hh:mm"

        let now = Date()
        storeDate = dateFormatter.string(from: now)
    
        cvType.layer.cornerRadius = 10 // 设置圆角半径，根据需要调整数值
        cvType.clipsToBounds = true // 确保内容在圆角区域内显示
        
        view.bringSubviewToFront(vTimeBackground)
        view.bringSubviewToFront(vContainer)
        
        initialHourIndex = hours.firstIndex(of: Int(selectHour) ?? 0)!
        initialMinuteIndex = minutes.firstIndex(of: Int(selectminute) ?? 0)!
        pkvTimer.selectRow(initialHourIndex, inComponent: 0, animated: false)
        pkvTimer.selectRow(initialMinuteIndex, inComponent: 1, animated: false)
    
        vCvShadow.layer.cornerRadius = 10.0 // 設定圓角半徑
        vCvShadow.layer.shadowColor = UIColor.gray.cgColor // 設置陰影顏色
        vCvShadow.layer.shadowOffset = CGSize(width: 0, height: 0) // 設置陰影偏移
        vCvShadow.layer.shadowRadius = 4.0 // 設置陰影半徑
        vCvShadow.layer.shadowOpacity = 0.9 // 設置陰影透明度
    }
    
    func setupediting() {
        
        if isEdit {
            cvType.isHidden = false
            vCvTypeBackground.isHidden = false
            tbvInput.isHidden = false
            selectActionIndex = recordActionIndex
            selectTypeIndex = recordTypeIndex
            mark = editEvent!.Note
            selectedActionIndexPath = IndexPath(item: recordActionIndex, section: 0)
            selectedTypeIndexPath = IndexPath(item: recordTypeIndex, section: 0)
            selectType = recordActionIndex
            switch selectType {
            case 0:
                cvTypelayout.itemSize = CGSize(width: 69, height: 120) // 设置宽度和高度
                cvType.collectionViewLayout = cvTypelayout
            case 1, 3:
                cvTypelayout.itemSize = CGSize(width: 117, height: 120) // 设置宽度和高度
                cvType.collectionViewLayout = cvTypelayout
            case 2:
                cvTypelayout.itemSize = CGSize(width: 87, height: 120) // 设置宽度和高度
                cvType.collectionViewLayout = cvTypelayout
            default:
                vCvTypeBackground.isHidden = true
                UIView.animate(withDuration: 0.5) { [self] in
                    self.btnAdd.transform = CGAffineTransform(translationX: 0, y: vTimeBackground.frame.height * 2 - 60)
                }
            }
            clickCount += 1
            if selectType < 4 {
                print(vCvTypeBackground.frame.height)
                UIView.animate(withDuration: 0.5) { [self] in
                    self.tbvInput.transform = CGAffineTransform(translationX: 0, y: vCvTypeBackground.frame.height)
                    self.vCvTypeBackground.transform = CGAffineTransform(translationX: 0, y: vCvTypeBackground.frame.height - 11)
                    self.btnAdd.transform = CGAffineTransform(translationX: 0, y: vTimeBackground.frame.height * 2 - 60)
                }
            }
        }
    }
    
    func setupNavigation() {
        
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        // 確定保持原始圖片的寬高比例，並根據較小的比例來縮放圖片
        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio,
                             height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,
                             height: size.height * widthRatio)
        }
        // 根據目標大小和新尺寸縮放圖片
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tbvInput.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.dateFormat = "yyyy/MM/dd EEEE a hh:mm"
        selectDate = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        vContainer.isHidden = true
        btnAdd.isHidden = false
    }
    
    @IBAction func save(_ sender: UIButton) {
        vContainer.isHidden = true
        btnAdd.isHidden = false
        if selectDate != "" {
            storeDate = selectDate
        }
        tbvRecord.reloadData()
    }
    
    @IBAction func add(_ sender: Any) {
        let realm = try! Realm()
        initialHourIndex = hours.firstIndex(of: 0)!
        initialMinuteIndex = minutes.firstIndex(of: 30)!
        pkvTimer.selectRow(initialHourIndex, inComponent: 0, animated: false)
        pkvTimer.selectRow(initialMinuteIndex, inComponent: 1, animated: false)
        if isEdit {
            try! realm.write {
                if selectActionIndex < 4 {
                    if selectTypeIndex != -1 {
                        if (selectActionIndex == 0 && (eatingItem == "" || eatingQuantity == "")) {
                            Alert().showAlert(title: NSLocalizedString("Error", comment: ""),
                                              message: NSLocalizedString("no click event", comment: ""),
                                              vc: self)
                        } else if (selectActionIndex == 1 && exerciseType == "") {
                            Alert().showAlert(title: NSLocalizedString("Error", comment: ""),
                                              message: NSLocalizedString("no click event", comment: ""),
                                              vc: self)
                        } else if (selectActionIndex == 3 && insulinQuantity == "") {
                            Alert().showAlert(title: NSLocalizedString("Error", comment: ""),
                                              message: NSLocalizedString("no click event", comment: ""),
                                              vc: self)
                        } else {
                            editEvent?.EventId = selectActionIndex
                            editEvent?.EventValue = selectTypeIndex
                            let eventAttribute = List<String>()
                            if selectActionIndex == 0 {
                                eventAttribute.append(eatingItem)
                                eventAttribute.append(eatingQuantity)
                            } else if selectActionIndex == 1 {
                                eventAttribute.append(exerciseType)
                                eventAttribute.append(selectHour + ":" + selectminute)
                            } else if selectActionIndex == 2 {
                                eventAttribute.append(selectHour + ":" + selectminute)
                            } else if selectActionIndex == 3 {
                                eventAttribute.append(insulinQuantity)
                            }
                            editEvent?.EventAttribute = eventAttribute
                            editEvent?.Note = mark
                        }
                    } else {
                        Alert().showAlert(title: NSLocalizedString("Error", comment: ""),
                                              message: NSLocalizedString("no click event", comment: ""),
                                              vc: self)
                    }
                } else {
                    editEvent?.EventId = selectActionIndex
                    editEvent?.EventValue = selectTypeIndex
                    let eventAttribute = List<String>()
                    if selectActionIndex == 0 {
                        eventAttribute.append(eatingItem)
                        eventAttribute.append(eatingQuantity)
                    } else if selectActionIndex == 1 {
                        eventAttribute.append(exerciseType)
                        eventAttribute.append(selectHour + ":" + selectminute)
                    } else if selectActionIndex == 2 {
                        eventAttribute.append(selectHour + ":" + selectminute)
                    } else if selectActionIndex == 3 {
                        eventAttribute.append(insulinQuantity)
                    }
                    editEvent?.EventAttribute = eventAttribute
                    editEvent?.Note = mark
                }
            }
            tbReload()
            navigationController?.popViewController(animated: true)
        } else {
            if (selectTypeIndex == -1 && selectActionIndex < 4) {
                Alert().showAlert(title: NSLocalizedString("Error", comment: ""),
                                  message: NSLocalizedString("no click event", comment: ""),
                                  vc: self)
            } else {
                if (selectActionIndex == 0 && (eatingItem == "" || eatingQuantity == "")) {
                    Alert().showAlert(title: NSLocalizedString("Error", comment: ""),
                                      message: NSLocalizedString("no click event", comment: ""),
                                      vc: self)
                } else if (selectActionIndex == 1 && exerciseType == "") {
                    Alert().showAlert(title: NSLocalizedString("Error", comment: ""),
                                      message: NSLocalizedString("no click event", comment: ""),
                                      vc: self)
                } else if (selectActionIndex == 3 && insulinQuantity == "") {
                    Alert().showAlert(title: NSLocalizedString("Error", comment: ""),
                                      message: NSLocalizedString("no click event", comment: ""),
                                      vc: self)
                } else {
                    let storeDateArray = storeDate.components(separatedBy: " ")
                    let dateTime = storeDateArray[0] + " " + storeDateArray[3] + " " + storeDateArray[2]
                    let eventAttribute = List<String>()
                    if selectActionIndex == 0 {
                        eventAttribute.append(eatingItem)
                        eventAttribute.append(eatingQuantity)
                    } else if selectActionIndex == 1 {
                        eventAttribute.append(exerciseType)
                        eventAttribute.append(selectHour + ":" + selectminute)
                    } else if selectActionIndex == 2 {
                        eventAttribute.append(selectHour + ":" + selectminute)
                    } else if selectActionIndex == 3 {
                        eventAttribute.append(insulinQuantity)
                    }
                    
                    try! realm.write{
                        realm.add(Event(ID: incrementID(), DateTime: storeDate, DisplayTime: dateTime, EventAttribute: eventAttribute, EventId: selectActionIndex, EventValue: selectTypeIndex, Note: mark, Check: true))
                    }
                    let eventRecordVC = EventRecordViewController()
                    navigationController?.pushViewController(eventRecordVC, animated: true)
                }
            }
        }
        selectHour = "00"
        selectminute = "30"
        tbvInput.reloadData()
        print(realm.configuration.fileURL!)
    }
    
    @IBAction func close(_ sender: Any) {
        vTimeBackground.isHidden = true
        selectHour = "00"
        selectminute = "30"
    }
    
    @IBAction func next(_ sender: Any) {
        vTimeBackground.isHidden = true
        tbvInput.reloadData()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text
        switch textField.tag {
        case 0: // 品名
            eatingItem = text ?? ""
        case 1: // 份量
            eatingQuantity = text ?? ""
        case 2: // 類型
            exerciseType = text ?? ""
        default: // 劑量
            insulinQuantity = text ?? ""
        }
    }
    
    func tbReload() {
        NotificationCenter.default.post(name: NotificationNames.tbReload, object: nil)
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Event.self).max(ofProperty: "ID") as Int? ?? 0) + 1
    }
}
// MARK: - Extension

extension LifeStyleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1 {
            return 40
        } else {
            if selectType == 0 || selectType == 1 {
                if indexPath.row == 0 || indexPath.row == 1{
                    return 50
                } else {
                    return 90
                }
            } else if selectType == 2 || selectType == 3{
                if indexPath.row == 0 {
                    return 50
                } else {
                    return 90
                }
            } else {
                return 90
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return 1
        } else {
            if selectType == 0 || selectType == 1 {
                return 3
            } else if selectType == 2 || selectType == 3{
                return 2
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            let cell = tbvRecord.dequeueReusableCell(withIdentifier: RecordTableViewCell.identifier, for: indexPath) as! RecordTableViewCell
            cell.lbTitle.text = NSLocalizedString("Record time", comment: "")
            cell.lbDate.text = storeDate
            cell.imgvIcon.image = resizeImage(image: UIImage(named: "ArrowDown2")!, targetSize: CGSize(width: 20, height: 20))
            cell.imgvIcon.contentMode = .scaleAspectFit
            cell.selectionStyle = .none
            return cell
        } else {
            switch selectType {
            case 0:
                if indexPath.row < 2 {
                    let txfCell = tbvInput.dequeueReusableCell(withIdentifier: NameTableViewCell.identifier,
                                                               for: indexPath) as! NameTableViewCell
                    txfCell.lbTitle.text = NSLocalizedString(eatTitleArray[indexPath.row], comment: "")
                    if indexPath.row == 0 {
                        txfCell.txfInput.tag = 0
                        if isToEdit {
                            if editEvent?.EventAttribute.count != 0 {
                                txfCell.txfInput.text = editEvent!.EventAttribute[0]
                            } else {
                                txfCell.txfInput.text = ""
                            }
                        } else {
                            txfCell.txfInput.text = ""
                        }
                        eatingItem = txfCell.txfInput.text!
                    } else {
                        txfCell.txfInput.tag = 1
                        if isToEdit {
                            if editEvent?.EventAttribute.count != 0 {
                                txfCell.txfInput.text = editEvent!.EventAttribute[1]
                            } else {
                                txfCell.txfInput.text = ""
                            }                        } else {
                            txfCell.txfInput.text = ""
                        }
                        eatingQuantity = txfCell.txfInput.text!
                        txfCell.txfInput.delegate = self
                    }
                    
                    txfCell.txfInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                    txfCell.txfInput.placeholder = NSLocalizedString("Add Product Name", comment: "")
                    txfCell.txfInput.textColor = .black
                    txfCell.selectionStyle = .none
                    
                    return txfCell
                } else {
                    let tvCell = tbvInput.dequeueReusableCell(withIdentifier: tbvTextViewCell.identifier,
                                                              for: indexPath) as! tbvTextViewCell
                    tvCell.lbTitle.text = NSLocalizedString(eatTitleArray[indexPath.row], comment: "")
                    lbPlaceHold = tvCell.lbPlaceHolder

                    if isToEdit {
                        if editEvent!.Note != "" {
                            tvCell.tvInput.text = editEvent!.Note
                            lbPlaceHold.isHidden = true
                        } else {
                            tvCell.tvInput.text = ""
                        }
                    } else {
                        tvCell.tvInput.text = ""
                    }
                    tvCell.tvInput.delegate = self
                    tvCell.selectionStyle = .none
                    return tvCell
                }
            case 1:
                if indexPath.row == 0 {
                    let txfCell = tbvInput.dequeueReusableCell(withIdentifier: NameTableViewCell.identifier,
                                                               for: indexPath) as! NameTableViewCell
                    txfCell.lbTitle.text = NSLocalizedString(exerciseTitleArray[indexPath.row], comment: "")
                    if isToEdit {
                        if editEvent?.EventAttribute.count != 0 {
                            txfCell.txfInput.text = editEvent!.EventAttribute[0]
                        } else {
                            txfCell.txfInput.text = ""
                        }
                    } else {
                        txfCell.txfInput.text = exerciseType
                    }
                    exerciseType = txfCell.txfInput.text!
                    txfCell.txfInput.textColor = .black
                    txfCell.txfInput.tag = 2
                    txfCell.txfInput.placeholder = NSLocalizedString("Add Product Name", comment: "")
                    txfCell.txfInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                    txfCell.selectionStyle = .none
                    return txfCell
                } else if indexPath.row == 1 {
                    let lbCell = tbvInput.dequeueReusableCell(withIdentifier: MailTableViewCell.identifier, for: indexPath) as! MailTableViewCell
                    lbCell.lbTitle.text = NSLocalizedString(exerciseTitleArray[indexPath.row], comment: "")
                    if isToEdit {
                        if editEvent?.EventAttribute.count != 0 {
                            lbCell.lbContent.text = editEvent!.EventAttribute[1]
                            let components = editEvent!.EventAttribute[1].components(separatedBy: ":")
                            selectHour = components[0]
                            selectminute = components[1]
                        } else {
                            lbCell.lbContent.text = selectHour + ":" + selectminute
                        }
                    } else {
                        lbCell.lbContent.text = selectHour + ":" + selectminute
                    }
                    
                    lbCell.lbContent.textColor = .lightGray
                    lbCell.selectionStyle = .none
                    return lbCell
                } else {
                    let tvCell = tbvInput.dequeueReusableCell(withIdentifier: tbvTextViewCell.identifier,
                                                              for: indexPath) as! tbvTextViewCell
                    tvCell.lbTitle.text = NSLocalizedString(exerciseTitleArray[indexPath.row], comment: "")
                    lbPlaceHold = tvCell.lbPlaceHolder
                    if isToEdit {
                        if mark != "" {
                            tvCell.tvInput.text = mark
                            lbPlaceHold.isHidden = true
                        } else {
                            tvCell.tvInput.text = ""
                        }
                    } else {
                        tvCell.tvInput.text = mark
                    }
                    tvCell.tvInput.delegate = self
                    tvCell.selectionStyle = .none
                    return tvCell
                }
            case 2:
                if indexPath.row == 0 {
                    let lbCell = tbvInput.dequeueReusableCell(withIdentifier: MailTableViewCell.identifier, for: indexPath) as! MailTableViewCell
                    lbCell.lbTitle.text = NSLocalizedString(sleepTitleArray[indexPath.row], comment: "")
                    if isToEdit {
                        lbCell.lbContent.text = editEvent!.EventAttribute[0]
                        let components = editEvent!.EventAttribute[0].components(separatedBy: ":")
                        selectHour = components[0]
                        selectminute = components[1]
                    } else {
                        lbCell.lbContent.text = selectHour + ":" + selectminute
                    }
                    lbCell.lbContent.textColor = .lightGray
                    lbCell.selectionStyle = .none
                   return lbCell
               } else {
                   let tvCell = tbvInput.dequeueReusableCell(withIdentifier: tbvTextViewCell.identifier,
                                                             for: indexPath) as! tbvTextViewCell
                   tvCell.lbTitle.text = NSLocalizedString(sleepTitleArray[indexPath.row], comment: "")
                   lbPlaceHold = tvCell.lbPlaceHolder
                   if isToEdit {
                       if editEvent!.Note != "" {
                           tvCell.tvInput.text = editEvent!.Note
                           lbPlaceHold.isHidden = true
                       } else {
                           tvCell.tvInput.text = ""
                       }
                   } else {
                       tvCell.tvInput.text = mark
                   }
                   tvCell.tvInput.delegate = self
                   tvCell.selectionStyle = .none
                   return tvCell
               }
            case 3:
                if indexPath.row == 0 {
                    let txfLbCell = tbvInput.dequeueReusableCell(withIdentifier: txfLbCell.identifier, for: indexPath) as! txfLbCell
                    txfLbCell.lbTitle.text = NSLocalizedString(insulinTitleArray[indexPath.row], comment: "")
                    if isToEdit {
                        if editEvent?.EventAttribute.count != 0 {
                            txfLbCell.txfInput.text = editEvent!.EventAttribute[0]
                        } else {
                            txfLbCell.txfInput.text = ""
                        }
                    } else {
                        txfLbCell.txfInput.text = ""
                    }
                    insulinQuantity = txfLbCell.txfInput.text!
                    txfLbCell.txfInput.tag = 3
                    txfLbCell.txfInput.delegate = self
                    txfLbCell.txfInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                    txfLbCell.selectionStyle = .none
                    return txfLbCell
                } else {
                    let tvCell = tbvInput.dequeueReusableCell(withIdentifier: tbvTextViewCell.identifier,
                                                              for: indexPath) as! tbvTextViewCell
                    tvCell.lbTitle.text = NSLocalizedString(insulinTitleArray[indexPath.row], comment: "")
                    tvCell.lbTitle.text = NSLocalizedString("Note", comment: "")
                    lbPlaceHold = tvCell.lbPlaceHolder
                    if isToEdit {
                        if editEvent!.Note != "" {
                            tvCell.tvInput.text = editEvent!.Note
                            lbPlaceHold.isHidden = true
                        } else {
                            tvCell.tvInput.text = ""
                        }
                    } else {
                        tvCell.tvInput.text = ""
                    }
                    tvCell.tvInput.delegate = self
                    tvCell.selectionStyle = .none
                    return tvCell
                }
            default:
                let tvCell = tbvInput.dequeueReusableCell(withIdentifier: tbvTextViewCell.identifier,
                                                          for: indexPath) as! tbvTextViewCell
                tvCell.lbTitle.text = NSLocalizedString("Note", comment: "")
                lbPlaceHold = tvCell.lbPlaceHolder
                if isToEdit {
                    if editEvent!.Note != "" {
                        lbPlaceHold.isHidden = true
                        tvCell.tvInput.text = editEvent!.Note
                    } else {
                        lbPlaceHold.isHidden = false
                        tvCell.tvInput.text = ""
                    }
                } else {
                    tvCell.tvInput.text = ""
                }
                tvCell.tvInput.delegate = self
                tvCell.selectionStyle = .none
                return tvCell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 1 {
            vContainer.isHidden = false
            btnAdd.isHidden = true
        } else {
            isToEdit = false
            if selectType == 1 {
                if indexPath.row == 1 {
                    vTimeBackground.isHidden = false
                }
            } else if selectType == 2 {
                if indexPath.row == 0 {
                    vTimeBackground.isHidden = false
                }
            }
        }
    }
}

extension LifeStyleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return 7
        } else {
            if selectType == 0 {
                registSelect = 5
                return 5
            } else if selectType == 1 || selectType == 3{
                registSelect = 3
                return 3
            } else if selectType == 2 {
                registSelect = 4
                return 4
            } else {
                return registSelect
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = cvAction.dequeueReusableCell(withReuseIdentifier: cvActionCell.identifier, for: indexPath) as! cvActionCell
            cell.lbTitle.text = NSLocalizedString(titleArray[indexPath.row], comment: "")
            cell.imgvIcon.image = resizeImage(image: UIImage(named: imgvArray[indexPath.row])!, targetSize: CGSize(width: 36, height: 36))
            if isToEdit && indexPath.row == recordActionIndex {
                cell.vBackground.backgroundColor = UIColor.clickBackground // 更改为选中的颜色，你可以替换为你的选中颜色
            }
            return cell
        } else {
            let cell = cvType.dequeueReusableCell(withReuseIdentifier: cvTypeCell.identifier, for: indexPath) as! cvTypeCell
            if isToEdit && indexPath.row == recordTypeIndex {
                cell.backgroundColor = UIColor.lifeStyleBackground // 更改为选中的颜色，你可以替换为你的选中颜色
            }

            switch selectType {
            case 0:
                cell.lbTitle.text = NSLocalizedString(typeEatArray[indexPath.row], comment: "")
                cell.imgvIcon.image = resizeImage(image: UIImage(named: imgvEatArray[indexPath.row])!, targetSize: CGSize(width: 20, height: 20))
            case 1:
                cell.lbTitle.text = NSLocalizedString(typexerciseArray[indexPath.row], comment: "")
                if let image = UIImage(named: imgvExerciseArray[indexPath.row]) {
                    cell.imgvIcon.image = resizeImage(image: image, targetSize: CGSize(width: 10, height: 10))
                }
            case 2:
                cell.lbTitle.text = NSLocalizedString(typeSleepArray[indexPath.row], comment: "")
                cell.imgvIcon.image = resizeImage(image: UIImage(named: imgvSleepArray[indexPath.row])!, targetSize: CGSize(width: 20, height: 20))
            case 3:
                cell.lbTitle.text = NSLocalizedString(typeInsulinArray[indexPath.row], comment: "")
                cell.imgvIcon.image = resizeImage(image: UIImage(named: imgvInsulin)!, targetSize: CGSize(width: 20, height: 20))
            default:
                break
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            eatingItem = ""
            eatingQuantity = ""
            exerciseType = ""
            insulinQuantity = ""
            mark = ""
            selectTypeIndex = -1
            selectActionIndex = indexPath.row
            cvType.isHidden = false
            vCvTypeBackground.isHidden = false
            tbvInput.isHidden = false
            lbPlaceHold.isHidden = false
            isToEdit = false
            // 初始化 pickerView 選取的
            selectHour = "00"
            selectminute = "30"
            if let previousIndexPath = selectedActionIndexPath,
               collectionView.indexPathsForVisibleItems.contains(previousIndexPath),
               let previousCell = collectionView.cellForItem(at: previousIndexPath) as? cvActionCell {
                previousCell.vBackground.backgroundColor = UIColor.lifeStyleBackground
            }
            // 设置新的被选中单元格的背景颜色
            let cell = collectionView.cellForItem(at: indexPath) as! cvActionCell
            cell.vBackground.backgroundColor = UIColor.clickBackground // 更改为选中的颜色，你可以替换为你的选中颜色
            // 更新选中的indexPath
            selectedActionIndexPath = indexPath
            selectType = indexPath.row
            tbvInput.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
                // 在这里执行需要延迟的代码
                switch selectType {
                case 0:
                    cvTypelayout.itemSize = CGSize(width: 69, height: 120) // 设置宽度和高度
                    cvType.collectionViewLayout = cvTypelayout
                case 1, 3:
                    cvTypelayout.itemSize = CGSize(width: 117, height: 120) // 设置宽度和高度
                    cvType.collectionViewLayout = cvTypelayout
                case 2:
                    cvTypelayout.itemSize = CGSize(width: 87, height: 120) // 设置宽度和高度
                    cvType.collectionViewLayout = cvTypelayout
                default:
                    if clickTpyeIndexPath != indexPath.row && clickCount == 0{
                        UIView.animate(withDuration: 0.3) { [self] in
                            self.btnAdd.transform = CGAffineTransform(translationX: 0, y: vTimeBackground.frame.height * 2)
                        }
                        clickCount += 1
                    } else {
                        UIView.animate(withDuration: 0.3) {
                            self.vCvTypeBackground.transform = .identity
                        }
                        UIView.animate(withDuration: 0.3) {
                            self.tbvInput.transform = .identity
                        }
                    }
                    clickTpyeIndexPath = indexPath.row
                }
                if selectType < 4 {
                    if isEdit {
                        UIView.animate(withDuration: 0.3) { [self] in
                            self.vCvTypeBackground.transform = CGAffineTransform(translationX: 0, y: self.vCvTypeBackground.frame.height)
                            self.tbvInput.transform = CGAffineTransform(translationX: 0, y: self.vCvTypeBackground.frame.height)
                        }
                    } else {
                        if clickTpyeIndexPath != indexPath.row && clickCount == 0 {
                            tbvInput.isHidden = true
                            UIView.animate(withDuration: 0.3) { [self] in
                                tbvInput.isHidden = false
                                self.tbvInput.transform = CGAffineTransform(translationX: 0, y: vCvTypeBackground.frame.height)
                                self.vCvTypeBackground.transform = CGAffineTransform(translationX: 0, y: vCvTypeBackground.frame.height)
                                self.btnAdd.transform = CGAffineTransform(translationX: 0, y: vTimeBackground.frame.height * 2)
                            }
                            clickCount += 1
                        } else {
                            UIView.animate(withDuration: 0.3) { [self] in
                                self.vCvTypeBackground.transform = CGAffineTransform(translationX: 0, y: vCvTypeBackground.frame.height)
                            }
                            UIView.animate(withDuration: 0.3) { [self] in
                                self.tbvInput.transform = CGAffineTransform(translationX: 0, y: vCvTypeBackground.frame.height)
                            }
                        }
                    }
                    clickTpyeIndexPath = indexPath.row
                }
                // 恢复第二个collectionView中的所有单元格为白色
                for item in 0..<cvType.numberOfItems(inSection: 0) {
                    let indexPath = IndexPath(item: item, section: 0)
                    let cell = cvType.cellForItem(at: indexPath) as! cvTypeCell
                    cell.backgroundColor = UIColor.white
                }
                // 如果是在編輯模式切換Action的cv時讓cv的cell變成全空白的
                // 然後將tableView的輸入都變回空
                if isToEdit {
                    recordTypeIndex = -1
                    let realm = try! Realm()
                    try! realm.write{
                        editEvent!.Note = ""
                        editEvent?.EventAttribute.removeAll()
                    }
                    
                }
                cvType.reloadData()
            }
        } else {
//            if clickTypeCount == 0 {
//                tbvInput.isHidden = false
//                UIView.animate(withDuration: 0.3) { [self] in
//                    self.tbvInput.transform = CGAffineTransform(translationX: 0, y: vCvTypeBackground.frame.height)
//                }
//                clickTypeCount += 1
//            }
            selectTypeIndex = indexPath.row
            if let previousIndexPath = selectedTypeIndexPath,
               let previousCell = collectionView.cellForItem(at: previousIndexPath) as? cvTypeCell {
                previousCell.backgroundColor = UIColor.white // 恢复为默认颜色，你可以根据需要替换为你的默认颜色
            }
            // 设置新的被选中单元格的背景颜色
            let cell = collectionView.cellForItem(at: indexPath) as! cvTypeCell
            cell.backgroundColor = UIColor.lifeStyleBackground // 更改为选中的颜色，你可以替换为你的选中颜色
            // 更新选中的indexPath
            selectedTypeIndexPath = indexPath
        }
    }
}

extension LifeStyleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 2
       }
       
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       if component == 0 {
           return hours.count
       } else {
           return minutes.count
       }
   }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(hours[row])"
        } else {
            return "\(minutes[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView,didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            selectHour = "\(hours[row])"
            if hours[row] < 10 {
                selectHour = "0" + selectHour
            }
        } else {
            selectminute = "\(minutes[row])"
            if minutes[row] < 10 {
                selectminute = "0" + selectminute
            }
        }
    }
}

extension LifeStyleViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 获取当前文本内容
        let currentText = textView.text
        // 获取将要插入的文本
        let newText = (currentText! as NSString).replacingCharacters(in: range, with: text)
        // 在这里可以执行你的即时更新操作
        // 例如，你可以将 newText 显示在另一个标签或进行其他处理
        if newText.isEmpty {
            lbPlaceHold.isHidden = false
        } else {
            lbPlaceHold.isHidden = true
        }
        if newText.count <= 100 {
            mark = newText
            return true
        } else {
            // 如果超过限制，阻止文本继续输入
            return false
        }
    }
}

extension LifeStyleViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1 || textField.tag == 3 {
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


