//
//  LifeStyleViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/2.
//

import UIKit

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
    
    @IBOutlet weak var cvType: UICollectionView!
    
    @IBOutlet weak var tbvInput: UITableView!
    
    // MARK: - Variables
    
    var selectDate: String = ""
    
    var storeDate: String = ""
    
    let titleArray: [String] = ["用餐", "運動", "睡眠", "胰島素", "起床", "洗澡", "其他"]

    let typeEatArray: [String] = ["早餐", "午餐", "晚餐", "點心", "飲料"]
    
    let typexerciseArray: [String] = ["高強度", "中強度", "低強度"]
    
    let typeSleepArray: [String] = ["就寢", "小睡", "小憩", "放鬆時刻"]
    
    let typeInsulinArray: [String] = ["速效型", "長效型", "未指定"]
    
    let imgvArray: [String] = ["meal", "exercise", "sleep", "insulin", "awaken", "bath", "other"]
    
    let imgvEatArray: [String] = ["breakfast", "lunch", "dinner", "snacks", "drinks"]
    
    let imgvExerciseArray: [String] = ["high_motion", "mid_motion", "low_motion"]
    
    let imgvSleepArray: [String] = ["sleep", "sleepy", "nap", "relax"]
   
    let imgvInsulin: String = "insulin"
    
    let eatTitleArray: [String] = ["品名", "份量", "註記"]
    
    let exerciseTitleArray: [String] = ["類型", "時長", "註記"]
    
    let sleepTitleArray: [String] = ["時長", "註記"]
    
    let insulinTitleArray: [String] = ["劑量", "註記"]
    
    var selectedActionIndexPath: IndexPath?
    var selectedTypeIndexPath: IndexPath?
    var selectType: Int = 0
    var cvTypelayout: UICollectionViewFlowLayout!
    
    var isViewShifted: Bool = false

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
        
        tbvRecord.register(UINib(nibName: "RecordTableViewCell", bundle: nil),
                           forCellReuseIdentifier: RecordTableViewCell.identifier)
        
        tbvInput.register(UINib(nibName: "NameTableViewCell", bundle: nil),
                          forCellReuseIdentifier: NameTableViewCell.identifier)
       
        tbvInput.register(UINib(nibName: "tbvTextViewCell", bundle: nil),
                          forCellReuseIdentifier: tbvTextViewCell.identifier)
        
        tbvInput.register(UINib(nibName: "HaveLabelTableViewCell", bundle: nil),
                          forCellReuseIdentifier: HaveLabelTableViewCell.identifier)
       
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
        
        vContainer.isHidden = true
        btnAdd.setTitle("新增", for: .normal)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.dateFormat = "yyyy/MM/dd EEEE a hh:mm"

        let now = Date()
        storeDate = dateFormatter.string(from: now)
    
        cvType.layer.cornerRadius = 10 // 设置圆角半径，根据需要调整数值
        cvType.clipsToBounds = true // 确保内容在圆角区域内显示
        tbvRecord.tag = 1
        tbvInput.tag = 2
        cvAction.tag = 1
        cvType.tag = 2
        cvType.isHidden = true
        vCvTypeBackground.isHidden = true
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
        tableViewHeight.constant = tbvInput.contentSize.height
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
        print(selectDate)
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
    }
}
// MARK: - Extension

extension LifeStyleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1 {
            return 30
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
            
            cell.lbTitle.text = "記錄時間"
            cell.lbDate.text = storeDate
            cell.imgvIcon.image = resizeImage(image: UIImage(named: "ArrowDown2")!, targetSize: CGSize(width: 20, height: 20))
            cell.imgvIcon.contentMode = .scaleAspectFit
            cell.selectionStyle = .none
            return cell
        } else {
//            let txfCell = tbvInput.dequeueReusableCell(withIdentifier: NameTableViewCell.identifier,
//                                                       for: indexPath) as! NameTableViewCell
            
//            let tvCell = tbvInput.dequeueReusableCell(withIdentifier: tbvTextViewCell.identifier,
//                                                      for: indexPath) as! tbvTextViewCell
            
//            let lbCell = tbvInput.dequeueReusableCell(withIdentifier: HaveLabelTableViewCell.identifier, for: indexPath) as! HaveLabelTableViewCell
            
//            let txfLbCell = tbvInput.dequeueReusableCell(withIdentifier: txfLbCell.identifier, for: indexPath) as! txfLbCell
            
//            tvCell.selectionStyle = .none
//            txfCell.selectionStyle = .none
//            lbCell.selectionStyle = .none
//            txfLbCell.selectionStyle = .none
            
            switch selectType {
            case 0:
                if indexPath.row < 2 {
                    let txfCell = tbvInput.dequeueReusableCell(withIdentifier: NameTableViewCell.identifier,
                                                               for: indexPath) as! NameTableViewCell
                    txfCell.lbTitle.text = eatTitleArray[indexPath.row]
                    txfCell.txfInput.text = "test"
                    return txfCell
                } else {
                    let tvCell = tbvInput.dequeueReusableCell(withIdentifier: tbvTextViewCell.identifier,
                                                              for: indexPath) as! tbvTextViewCell
                    tvCell.lbTitle.text = eatTitleArray[indexPath.row]
                    tvCell.tvInput.text = "Additional notes"
                    return tvCell
                }
            case 1:
                if indexPath.row == 0 {
                    let txfCell = tbvInput.dequeueReusableCell(withIdentifier: NameTableViewCell.identifier,
                                                               for: indexPath) as! NameTableViewCell
                    txfCell.lbTitle.text = exerciseTitleArray[indexPath.row]
                    txfCell.txfInput.text = "添加"
                    return txfCell
                } else if indexPath.row == 1 {
                    let lbCell = tbvInput.dequeueReusableCell(withIdentifier: HaveLabelTableViewCell.identifier, for: indexPath) as! HaveLabelTableViewCell
                    lbCell.lbTitle.text = exerciseTitleArray[indexPath.row]
                    lbCell.lbContent.text = "00:30"
                    return lbCell
                } else {
                    let tvCell = tbvInput.dequeueReusableCell(withIdentifier: tbvTextViewCell.identifier,
                                                              for: indexPath) as! tbvTextViewCell
                    tvCell.lbTitle.text = exerciseTitleArray[indexPath.row]
                    return tvCell
                }
            case 2:
                if indexPath.row == 0 {
                    let lbCell = tbvInput.dequeueReusableCell(withIdentifier: HaveLabelTableViewCell.identifier, for: indexPath) as! HaveLabelTableViewCell
                   lbCell.lbTitle.text = sleepTitleArray[indexPath.row]
                   lbCell.lbContent.text = "00:30"
                   return lbCell
               } else {
                   let tvCell = tbvInput.dequeueReusableCell(withIdentifier: tbvTextViewCell.identifier,
                                                             for: indexPath) as! tbvTextViewCell
                   tvCell.lbTitle.text = sleepTitleArray[indexPath.row]
                   tvCell.tvInput.text = "Additional notes"
                   return tvCell
               }
            case 3:
                if indexPath.row == 0 {
                    let txfLbCell = tbvInput.dequeueReusableCell(withIdentifier: txfLbCell.identifier, for: indexPath) as! txfLbCell
                    txfLbCell.lbTitle.text = insulinTitleArray[indexPath.row]
                    return txfLbCell
                } else {
                    let tvCell = tbvInput.dequeueReusableCell(withIdentifier: tbvTextViewCell.identifier,
                                                              for: indexPath) as! tbvTextViewCell
                    tvCell.lbTitle.text = insulinTitleArray[indexPath.row]
                    tvCell.lbTitle.text = "註記"
                    tvCell.tvInput.text = "Additional notes"
                    return tvCell
                }
            default:
                let tvCell = tbvInput.dequeueReusableCell(withIdentifier: tbvTextViewCell.identifier,
                                                          for: indexPath) as! tbvTextViewCell
                tvCell.lbTitle.text = "註記"
                tvCell.tvInput.text = "Additional notes"
                return tvCell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vContainer.isHidden = false
        btnAdd.isHidden = true
    }
}

extension LifeStyleViewController: UICollectionViewDelegate,
                                   UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return 7
        } else {
            print("test=======================")
            if selectType == 0 {
                return 5
            } else if selectType == 1 || selectType == 3{
                return 3
            } else if selectType == 2 {
                return 4
            } else {
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = cvAction.dequeueReusableCell(withReuseIdentifier: cvActionCell.identifier, for: indexPath) as! cvActionCell
            cell.lbTitle.text = titleArray[indexPath.row]
            cell.imgvIcon.image = resizeImage(image: UIImage(named: imgvArray[indexPath.row])!, targetSize: CGSize(width: 36, height: 36))
            return cell
        } else {
            let cell = cvType.dequeueReusableCell(withReuseIdentifier: cvTypeCell.identifier, for: indexPath) as! cvTypeCell
            switch selectType {
            case 0:
                cell.lbTitle.text = typeEatArray[indexPath.row]
                cell.imgvIcon.image = resizeImage(image: UIImage(named: imgvEatArray[indexPath.row])!, targetSize: CGSize(width: 20, height: 20))
            case 1:
                cell.lbTitle.text = typexerciseArray[indexPath.row]
                if let image = UIImage(named: imgvExerciseArray[indexPath.row]) {
                    cell.imgvIcon.image = resizeImage(image: image, targetSize: CGSize(width: 10, height: 10))
                }
            case 2:
                cell.lbTitle.text = typeSleepArray[indexPath.row]
                cell.imgvIcon.image = resizeImage(image: UIImage(named: imgvSleepArray[indexPath.row])!, targetSize: CGSize(width: 20, height: 20))
            case 3:
                cell.lbTitle.text = typeInsulinArray[indexPath.row]
                cell.imgvIcon.image = resizeImage(image: UIImage(named: imgvInsulin)!, targetSize: CGSize(width: 20, height: 20))
            default:
                break
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            cvType.isHidden = false
            vCvTypeBackground.isHidden = false
            if let previousIndexPath = selectedActionIndexPath {
                let previousCell = collectionView.cellForItem(at: previousIndexPath) as! cvActionCell
                previousCell.vBackground.backgroundColor = UIColor.lifeStyleBackground // 恢复为默认颜色，你可以根据需要替换为你的默认颜色
            }
            // 设置新的被选中单元格的背景颜色
            let cell = collectionView.cellForItem(at: indexPath) as! cvActionCell
            cell.vBackground.backgroundColor = UIColor.clickBackground // 更改为选中的颜色，你可以替换为你的选中颜色
            // 更新选中的indexPath
            selectedActionIndexPath = indexPath
            selectType = indexPath.row
            // 恢复第二个collectionView中的所有单元格为白色
            switch selectType {
            case 0:
                cvTypelayout.itemSize = CGSize(width: 69, height: 120) // 设置宽度和高度
                cvType.collectionViewLayout = cvTypelayout
            case 1, 3:
                cvTypelayout.itemSize = CGSize(width: 117, height: 120) // 设置宽度和高度
                cvType.collectionViewLayout = cvTypelayout
            case 2:
                cvTypelayout.itemSize = CGSize(width: 90, height: 120) // 设置宽度和高度
                cvType.collectionViewLayout = cvTypelayout
            default:
//                print(isViewShifted)
                vCvTypeBackground.isHidden = true
                cvType.isHidden = true
                if isViewShifted {
                    UIView.animate(withDuration: 0.3) {
                        self.tbvInput.transform = .identity
                    }
                } else {
                    UIView.animate(withDuration: 0.3) { [self] in
                        self.tbvInput.transform = CGAffineTransform(translationX: 0, y: tbvInput.frame.height + 1)
                    }
                }
                // 切换状态
                isViewShifted.toggle()
            }
            
            if selectType < 4 {
                if isViewShifted {
                    UIView.animate(withDuration: 0.3) {
                        self.tbvInput.transform = .identity
                    }
                } else {
                    UIView.animate(withDuration: 0.3) { [self] in
                        self.tbvInput.transform = CGAffineTransform(translationX: 0, y: tbvInput.frame.height + 1 + vCvTypeBackground.frame.height)
                    }
                }
                // 切换状态
                isViewShifted.toggle()
            }
            for item in 0..<cvType.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                let cell = cvType.cellForItem(at: indexPath) as! cvTypeCell
                cell.backgroundColor = UIColor.white
            }
            cvType.reloadData()
        } else {
            if let previousIndexPath = selectedTypeIndexPath,
               let previousCell = collectionView.cellForItem(at: previousIndexPath) as? cvTypeCell {
                previousCell.backgroundColor = UIColor.white // 恢复为默认颜色，你可以根据需要替换为你的默认颜色
            }
            // 设置新的被选中单元格的背景颜色
            let cell = collectionView.cellForItem(at: indexPath) as! cvTypeCell
            cell.backgroundColor = UIColor.lifeStyleBackground // 更改为选中的颜色，你可以替换为你的选中颜色
            // 更新选中的indexPath
            selectedTypeIndexPath = indexPath
            print(selectedTypeIndexPath!.row)
        }
    }
    
}
// MARK: - Protocol


