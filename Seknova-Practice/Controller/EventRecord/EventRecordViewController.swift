//
//  EventRecordViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/11/1.
//

import UIKit

import RealmSwift

class EventRecordViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tbvEventRecord: UITableView!
    
    // MARK: - Variables
    
//    let titleArray: [[String]] = [["早餐", "午餐", "晚餐", "點心", "飲料"],
//                                  ["高強度", "中強度", "低強度"],
//                                  ["就寢", "小睡", "小憩", "放鬆時刻"],
//                                  ["速效型", "長效型", "未指定"]]
//
    let titleArray: [[String]] = [["Breakfast", "Lunch", "Dinner", "Snack", "Drinks"],
                                  ["High Intensity", "Medium Intensity", "Low Intensity"],
                                  ["Sleep", "Nap", "Rest", "Relax time"],
                                  ["Rapid acting", "Long acting", "Unspecified"]]
    
//    let otherArray: [String] = ["起床", "洗澡", "其他"]
    let otherArray: [String] = ["Get up", "Bath", "Others"]
    
//    let ContentArray: [[String]] = [["品名:", "份量:", "註記:"],
//                                    ["類型:", "時長:", "註記:"],
//                                    ["時長:", "註記:"],
//                                    ["劑量:", "註記:"]]
    
    let ContentArray: [[String]] = [["Meal Name:", "Quantity:", "Note:"],
                                    ["Exercise Type:", "During Time:", "Note:"],
                                    ["During Time:", "Note:"],
                                    ["Dose:", "Note:"]]

    
    var rightButtonItem: UIBarButtonItem!
    
    var currentDateString: String = ""
    
    var yesterdayDateString: String = ""
    
    var isEdit: Bool = false
   
    var currentEventStruct: [EventStruct] = []
    
    var yesterdayEventStruct: [EventStruct] = []
    
    var selectIndex: Bool = false
    
    var selectCurrentIndex: IndexPath?

    var selectYesterdayIndex: IndexPath?
    
    var deleteIndex: IndexPath?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        // 获取当前时间
        let currentDate = Date()
        // 获取昨天时间
        let calendar = Calendar.current
        if let yesterday = calendar.date(byAdding: .day, value: -1, to: currentDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            // 格式化成字符串
            currentDateString = dateFormatter.string(from: currentDate)
            yesterdayDateString = dateFormatter.string(from: yesterday)
        }
        
        setupDbData()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTableView),
                                               name: NotificationNames.tbReload,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        title = NSLocalizedString("Event log", comment: "")
        tbvEventRecord.register(UINib(nibName: "eventRecordCell", bundle: nil),
                                forCellReuseIdentifier: "eventRecordCell")
        tbvEventRecord.delegate = self
        tbvEventRecord.dataSource = self
        
    }
    
    func setupNavigation() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        rightButtonItem = UIBarButtonItem(title: NSLocalizedString("Delete", comment: ""), style: .plain, target: self, action: #selector(action))
        navigationItem.rightBarButtonItem = rightButtonItem
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
    func setupDbData() {
        currentEventStruct = []
        yesterdayEventStruct = []
        let currentDateData = fetchDbData(Date: currentDateString)
        let yesterdayDateData = fetchDbData(Date: yesterdayDateString)
        for i in 0..<currentDateData.count {
            currentEventStruct.append(EventStruct(ID: currentDateData[i].ID,
                                                  DateTime: currentDateData[i].DateTime,
                                                  DisplayTime: currentDateData[i].DisplayTime,
                                                  EventAttribute: currentDateData[i].EventAttribute,
                                                  EventId: currentDateData[i].EventId,
                                                  EventValue: currentDateData[i].EventValue,
                                                  Note: currentDateData[i].Note,
                                                  Check: currentDateData[i].Check))
        }
        
        for i in 0..<yesterdayDateData.count {
            yesterdayEventStruct.append(EventStruct(ID: yesterdayDateData[i].ID,
                                                    DateTime: yesterdayDateData[i].DateTime,
                                                    DisplayTime: yesterdayDateData[i].DisplayTime,
                                                    EventAttribute: yesterdayDateData[i].EventAttribute,
                                                    EventId: yesterdayDateData[i].EventId,
                                                    EventValue: yesterdayDateData[i].EventValue,
                                                    Note: yesterdayDateData[i].Note,
                                                    Check: yesterdayDateData[i].Check))
        }
    }
    
    func fetchDbData(Date: String) -> Results<Event>{
        let realm = try! Realm()
        let results = realm.objects(Event.self).filter("DisplayTime BEGINSWITH %@", Date)
        return results
    }
    // MARK: - IBAction
    @objc func action() {
        if isEdit {
            rightButtonItem.title = NSLocalizedString("Delete", comment: "")
        } else {
            rightButtonItem.title = NSLocalizedString("Edit", comment: "")
        }
        isEdit.toggle()
        tbvEventRecord.reloadData()
    }
    
    func filterEvents(for date: String) -> Int {
        let realm = try! Realm()
        let eventData = realm.objects(Event.self)
        
        let filteredEvents = eventData.filter { event in
            let components = event.DisplayTime.components(separatedBy: " ")
            return components.count > 0 && components[0] == date
        }
        
        return filteredEvents.count
    }
    
    @objc func currentDayButtonPressed(_ sender: UIButton) {
        let indexPath: IndexPath
        let id: Int
        var isSecondSection: Bool = false
        if sender.tag < currentEventStruct.count {
                // 在第一個 section 中
            indexPath = IndexPath(row: sender.tag, section: 0)
            id = currentEventStruct[indexPath.row].ID
        } else {
            // 在第二個 section 中
            indexPath = IndexPath(row: sender.tag - currentEventStruct.count, section: 1)
            id = yesterdayEventStruct[indexPath.row].ID
            isSecondSection = true
        }
        
        let realm = try! Realm()
        if isEdit {
            let delectCell = realm.objects(Event.self).where {
                $0.ID == id
            }[0]
            try! realm.write {
                realm.delete(delectCell)
            }
            if isSecondSection {
                yesterdayEventStruct.remove(at: indexPath.row)
            } else {
                currentEventStruct.remove(at: indexPath.row)
            }
            tbvEventRecord.deleteRows(at: [indexPath], with: .automatic)
            tbvEventRecord.reloadData()
        } else {

            let editCell = realm.objects(Event.self).where {
                $0.ID == id
            }[0]
            let lifeStyleVC = LifeStyleViewController()
            if isSecondSection {
                lifeStyleVC.recordActionIndex = yesterdayEventStruct[indexPath.row].EventId
                lifeStyleVC.recordTypeIndex = yesterdayEventStruct[indexPath.row].EventValue
            } else {
                lifeStyleVC.recordActionIndex = currentEventStruct[indexPath.row].EventId
                lifeStyleVC.recordTypeIndex = currentEventStruct[indexPath.row].EventValue
            }
            lifeStyleVC.isToEdit = true
            lifeStyleVC.isEdit = true
            lifeStyleVC.editEvent = editCell
            navigationController?.pushViewController(lifeStyleVC, animated: true)
        }
    }
    
    @objc func reloadTableView() {
        setupDbData()
        tbvEventRecord.reloadData()
    }
}
// MARK: - Extension

extension EventRecordViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    // 每個cell 的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {
            if selectCurrentIndex == indexPath && selectIndex{
                switch currentEventStruct[indexPath.row].EventId {
                case 0, 1:
                    return 162
                case 2, 3:
                    return 120
                default:
                    return 95
                }
            } else {
                return 54
            }
        } else {
            if selectCurrentIndex == indexPath && selectIndex{
                switch yesterdayEventStruct[indexPath.row].EventId {
                case 0, 1:
                    return 162
                case 2, 3:
                    return 120
                default:
                    return 95
                }
            } else {
                return 54
            }
        }
    }
    // 每個header 的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        // 調整文本的位置
        label.frame = CGRect(x: tableView.bounds.width / 2 - 30, y: 15,
                             width: tableView.bounds.size.width , height: 20)
        
        switch section {
        case 0:
            label.text = currentDateString
        default:
            label.text = yesterdayDateString
        }
        headerView.addSubview(label)
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return currentEventStruct.count
        default:
            return yesterdayEventStruct.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvEventRecord.dequeueReusableCell(withIdentifier: "eventRecordCell", for: indexPath) as! eventRecordCell
        if !isEdit {
            cell.btnAction.setImage(resizeImage(image: UIImage(named: "edit")!,
                                                targetSize: CGSize(width: 35, height: 35)),
                                    for: .normal)
        } else {
            cell.btnAction.setImage(resizeImage(image: UIImage(named: "waste")!,
                                                targetSize: CGSize(width: 35, height: 35)),
                                    for: .normal)
        }

        if indexPath.section == 0 {
            if currentEventStruct[indexPath.row].EventId < 4 {
                cell.lbTitle.text = NSLocalizedString(titleArray[currentEventStruct[indexPath.row].EventId][currentEventStruct[indexPath.row].EventValue], comment: "")
            } else {
                cell.lbTitle.text = NSLocalizedString(otherArray[currentEventStruct[indexPath.row].EventId - 4], comment: "")
            }
            cell.lbTime.text = String(currentEventStruct[indexPath.row].DisplayTime.dropFirst(5))
            
            switch currentEventStruct[indexPath.row].EventId {
            case 0, 1:
                cell.lbNameTitle.text = NSLocalizedString("\(ContentArray[currentEventStruct[indexPath.row].EventId][0])", comment: "")
                cell.lbQuantityTitle.text = NSLocalizedString("\(ContentArray[currentEventStruct[indexPath.row].EventId][1])", comment: "")
                cell.lbMarkTitle.text = NSLocalizedString("\(ContentArray[currentEventStruct[indexPath.row].EventId][2])", comment: "")
                cell.lbName.text = currentEventStruct[indexPath.row].EventAttribute[0]
                cell.lbQuantity.text = currentEventStruct[indexPath.row].EventAttribute[1]
                cell.lbMark.text = currentEventStruct[indexPath.row].Note
            case 2, 3:
                cell.lbNameTitle.text = NSLocalizedString("\(ContentArray[currentEventStruct[indexPath.row].EventId][0])", comment: "")
                cell.lbQuantityTitle.text = NSLocalizedString("Note:", comment: "")
                cell.lbName.text = currentEventStruct[indexPath.row].EventAttribute[0]
                cell.lbQuantity.text = currentEventStruct[indexPath.row].Note
            default:
                cell.lbNameTitle.text = NSLocalizedString("Note:", comment: "")
                cell.lbName.text = currentEventStruct[indexPath.row].Note
            }
            cell.btnAction.tag = indexPath.row
        } else {
            
            if yesterdayEventStruct[indexPath.row].EventId < 4 {
                cell.lbTitle.text = titleArray[yesterdayEventStruct[indexPath.row].EventId][yesterdayEventStruct[indexPath.row].EventValue]
            } else {
                cell.lbTitle.text = otherArray[yesterdayEventStruct[indexPath.row].EventId - 4]
            }
            cell.lbTime.text = String(yesterdayEventStruct[indexPath.row].DisplayTime.dropFirst(5))
            
            switch yesterdayEventStruct[indexPath.row].EventId {
            case 0, 1:
                cell.lbNameTitle.text = NSLocalizedString("\(ContentArray[yesterdayEventStruct[indexPath.row].EventId][0])", comment: "")
                cell.lbQuantityTitle.text = NSLocalizedString("\(ContentArray[yesterdayEventStruct[indexPath.row].EventId][1])", comment: "")
                cell.lbMarkTitle.text = NSLocalizedString("\(ContentArray[yesterdayEventStruct[indexPath.row].EventId][2])", comment: "")
                cell.lbName.text = yesterdayEventStruct[indexPath.row].EventAttribute[0]
                cell.lbQuantity.text = yesterdayEventStruct[indexPath.row].EventAttribute[1]
                cell.lbMark.text = yesterdayEventStruct[indexPath.row].Note
            case 2, 3:
                cell.lbNameTitle.text = NSLocalizedString("\(ContentArray[yesterdayEventStruct[indexPath.row].EventId][0])", comment: "")
                cell.lbQuantityTitle.text = NSLocalizedString("Note:", comment: "")
                cell.lbName.text = yesterdayEventStruct[indexPath.row].EventAttribute[0]
                cell.lbQuantity.text = yesterdayEventStruct[indexPath.row].Note
            default:
                cell.lbNameTitle.text = NSLocalizedString("Note:", comment: "")
                cell.lbName.text = yesterdayEventStruct[indexPath.row].Note
            }
            cell.btnAction.tag = currentEventStruct.count + indexPath.row
        }
        
        cell.btnAction.addTarget(self,
                                 action: #selector(currentDayButtonPressed),
                                 for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        if indexPath.section == 0 {
            selectCurrentIndex = indexPath
        } else {
            selectCurrentIndex = indexPath
        }
        selectIndex.toggle()
        tableView.endUpdates()
    }
}


// MARK: - Protocol

