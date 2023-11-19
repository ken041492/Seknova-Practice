//
//  RotateHistoryViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/11/16.
//

import UIKit

import Charts

import RealmSwift

class RotateHistoryViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var lcvHistory: LineChartView!
   
    @IBOutlet weak var btnRotate: UIButton!
    
    @IBOutlet weak var btnMoveCurrent: UIButton!
    
    @IBOutlet weak var vBackground: UIView!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbTime: UILabel!
    
    @IBOutlet weak var lbContent: UILabel!
    
    @IBOutlet weak var sgTime: UISegmentedControl!
    
    // MARK: - Variables
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let titleArray: [[String]] = [["早餐", "午餐", "晚餐", "點心", "飲料"],
                                  ["高強度", "中強度", "低強度"],
                                  ["就寢", "小睡", "小憩", "放鬆時刻"],
                                  ["速效型", "長效型", "未指定"]]
    
    let imgvArray: [[String]] = [["breakfast", "lunch", "dinner", "snacks", "drinks"],
                                 ["high_motion", "mid_motion", "low_motion"],
                                 ["sleep", "sleepy", "nap", "relax"],
                                 ["insulin", "insulin", "insulin"]]
    
    var dataEntries: [ChartDataEntry] = []
    
    let originTime = Date().timeIntervalSince1970

    var selectTime: Double = 3600

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        setupChart()
        updateChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        appDelegate.interfaceOrientation = .landscape
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        appDelegate.interfaceOrientation = .portrait
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        vBackground.isHidden = true
    }
    
    func setupNavigation() {
        title = "History"
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let rightButtonItem = UIBarButtonItem(image: resizeImage(image: UIImage(named: "reload")!, targetSize: CGSize(width: 25, height: 25)), style: .plain, target: self, action: #selector(updateChart))
        
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    func setupChart() {
        // 設定x軸
        lcvHistory.xAxis.labelPosition = .bottom
        lcvHistory.xAxis.drawGridLinesEnabled = true // 顯示X軸線
        lcvHistory.xAxis.avoidFirstLastClippingEnabled = true // 不要超出x軸的範圍

        lcvHistory.leftAxis.drawGridLinesEnabled = true // 顯示Y軸線
        lcvHistory.rightAxis.enabled = false // 不顯示右邊Y軸
        lcvHistory.rightAxis.drawGridLinesEnabled = true // 顯示Y軸線

        lcvHistory.legend.enabled = false // 不顯示圖例
        lcvHistory.scaleYEnabled = false // 取消Y轴缩放
        lcvHistory.highlightPerTapEnabled = true
        lcvHistory.clipValuesToContentEnabled = true
        
        lcvHistory.delegate = self
        lcvHistory.isUserInteractionEnabled = true
        
        lcvHistory.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
       
        lcvHistory.leftAxis.axisMaximum = 400
        lcvHistory.leftAxis.axisMinimum = 0
        
        let xAxis = lcvHistory.xAxis // 获取 X 轴
        xAxis.valueFormatter = HistoryChartXAxisFormatter() // 设置 X 轴的值格式化器
        xAxis.labelFont = UIFont.systemFont(ofSize: 7.0) // 設定 X 軸標籤字體大小
    }
    @objc func updateChart() {
        dataEntries = []
        let realm = try! Realm()
        let events = realm.objects(Event.self)
        for event in events {
            if event.EventId < 4 {
                let entry = ChartDataEntry(x: stringToTimestamp(event.DisplayTime)!,
                                           y: Double(20),
                                           icon: resizeImage(image: UIImage(named: imgvArray[event.EventId][event.EventValue])!,
                                                             targetSize: CGSize(width: 30, height: 30)))
                dataEntries.append(entry)

            }
        }
        // 获取当前时间戳
        let currentTime = Date().timeIntervalSince1970
        
        // 更新折线图数据集
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Blood Sugar")
        dataSet.colors = [NSUIColor.clear] // 设置折线的颜色
        dataSet.drawCirclesEnabled = false // 显示数据点的圆圈
        dataSet.drawValuesEnabled = false // 显示数据点的值
//        dataSet.highlightEnabled = false // 取消选中时高亮
        dataSet.drawIconsEnabled = true // 啟用圖標繪製
        dataSet.highlightColor = .clear // 设置高亮颜


        let data = LineChartData(dataSet: dataSet)
        lcvHistory.data = data
        // 设置 X 轴的范围为从当前时间戳到当前时间往后1小时
        lcvHistory.xAxis.setLabelCount(6, force: true) //

        lcvHistory.xAxis.axisMinimum = currentTime - (60 * 60 * 24 * 14)
        lcvHistory.xAxis.axisMaximum = currentTime
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
    
    func stringToTimestamp(_ dateString: String) -> TimeInterval? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm a"

        // 新增這一行，指定 PM 的標誌符
        dateFormatter.amSymbol = "上午"
        dateFormatter.pmSymbol = "下午"

        if let date = dateFormatter.date(from: dateString) {
            return date.timeIntervalSince1970
        } else {
            return nil
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func moveCurrent(_ sender: Any) {
        updateChart()
        lcvHistory.moveViewToX(Date().timeIntervalSince1970)
    }
    
    
    @IBAction func sgChange(_ sender: Any) {
        
        if sgTime.selectedSegmentIndex == 0 {
           selectTime = 60 * 60 * 1
        } else if sgTime.selectedSegmentIndex == 1 {
            selectTime = 60 * 60 * 3
        } else if sgTime.selectedSegmentIndex == 2 {
            selectTime = 60 * 60 * 6
        } else if sgTime.selectedSegmentIndex == 3 {
            selectTime = 60 * 60 * 12
        } else {
            selectTime = 60 * 60 * 24
        }
        let when = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.lcvHistory.moveViewToX(self.selectTime)
        }
        updateChart()
    }
}
// MARK: - Extension

extension RotateHistoryViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("Chart value selected at x: \(entry.x), y: \(entry.y)")
        let realm = try! Realm()
        let events = realm.objects(Event.self)
        for event in events {
            if event.EventId < 4 {
                if stringToTimestamp(event.DisplayTime) == entry.x {
                    vBackground.isHidden = false
                    lbTitle.text = titleArray[event.EventId][event.EventValue]
                    lbTime.text = String(event.DisplayTime.dropFirst(5))
                    lbContent.text = event.EventAttribute[0]
                }
            }
        }
        
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("nothing selected")
        vBackground.isHidden = true
    }
}
// MARK: - Protocol
