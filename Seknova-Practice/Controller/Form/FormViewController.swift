//
//  FormViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/16.
//

import UIKit

import Charts

import CoreGraphics

class FormViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var lbDate: UILabel!
   
    @IBOutlet weak var lbAvailable: UILabel!
    
    @IBOutlet weak var segmentType: UISegmentedControl!
    
    @IBOutlet weak var segmentDate: UISegmentedControl!
   
    @IBOutlet weak var chartDaily: LineChartView!
    
    @IBOutlet weak var chartTime: BarChartView!
    
    
    // MARK: - Variables
   
    var dataEntries = [BarChartDataEntry]()

    let timeLabel = [">240", "180-240", "70-180", "<70"]

    let xValues = ["12am", "3am", "6am", "9am", "12pm", "3pm", "6pm", "9pm"]

    var currentDates: String = ""
    
    var afterDay: String = ""
    
    var count1: Double = 0 // >240
    
    var count2: Double = 0 // 180-240
    
    var count3: Double = 0 // 70-180
    
    var count4: Double = 0 // <70
    
    var totalCountArr: [Double] = []
    
    var totalCount: Double = 0
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        setChartDaily()
        setChartTime()
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
        chartTime.isHidden = true
        chartDaily.isHidden = false
        currentDates = getCurrentDateFormatted()
        afterDay = getDateAfterSevenDays(day: 7)
        lbDate.text = "\(afterDay) - \(currentDates)"
    }
    
    func setupNavigation() {
        title = "報表"
        let backButton = UIBarButtonItem()
        backButton.title = "返回"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    // 設置 Daily Patterns 的 Chart
    func setChartDaily() {
        // 設定x軸
        chartDaily.xAxis.labelPosition = .bottom
        chartDaily.xAxis.drawGridLinesEnabled = false // 顯示X軸線
        chartDaily.xAxis.avoidFirstLastClippingEnabled = false // 不要超出x軸的範圍
        
        chartDaily.leftAxis.drawGridLinesEnabled = true // 顯示Y軸線
        chartDaily.rightAxis.drawGridLinesEnabled = false // 顯示Y軸線
        chartDaily.rightAxis.enabled = false // 不顯示右邊Y軸
        chartDaily.leftAxis.drawAxisLineEnabled = false
        
        chartDaily.legend.enabled = false // 不顯示圖例
        chartDaily.scaleYEnabled = false // 取消Y轴缩放
        chartDaily.drawBordersEnabled = false // 不顯示邊框
        
        chartDaily.scaleXEnabled = false // 取消X轴缩放
        chartDaily.doubleTapToZoomEnabled = false // 取消雙擊縮放
        chartDaily.highlightPerTapEnabled = false // 取消點擊高亮
        chartDaily.leftAxis.drawBottomYLabelEntryEnabled = false // 不顯示最小值
        
        chartDaily.leftAxis.axisMinimum = 0
        chartDaily.leftAxis.axisMaximum = 350
        chartDaily.leftAxis.granularity = 50
        chartDaily.leftAxis.labelCount = 8 // 设置标签数量
        
        chartDaily.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        chartDaily.xAxis.labelCount = xValues.count // 设置标签的数量
        chartDaily.xAxis.setLabelCount(xValues.count, force: true) // 设置标签的数量
        setDailyData()
    }
    // 設置 Time in Target 的 Chart
    func setChartTime() {
        chartTime.xAxis.labelPosition = .bottom
        chartTime.xAxis.drawGridLinesEnabled = false // 隱藏X軸線
        chartTime.xAxis.drawAxisLineEnabled = false // 隱藏X軸線
        chartTime.xAxis.avoidFirstLastClippingEnabled = false // 不要超出x軸的範圍
        chartTime.leftAxis.drawGridLinesEnabled = false // 隱藏Y軸線
        chartTime.leftAxis.enabled = false
        chartTime.rightAxis.enabled = false // 不顯示右邊Y軸
        chartTime.rightAxis.drawGridLinesEnabled = false // 隱藏Y軸線
        chartTime.doubleTapToZoomEnabled = false // 取消雙擊縮放
        chartTime.legend.enabled = false // 不顯示圖例
        chartTime.scaleYEnabled = false // 取消Y轴缩放
        chartTime.highlightPerTapEnabled = false // 取消點擊高亮
        chartTime.drawValueAboveBarEnabled = true // 顯示數值
        
        chartTime.xAxis.valueFormatter = IndexAxisValueFormatter(values: timeLabel)
        chartTime.xAxis.labelCount = timeLabel.count // 设置标签的数量
        chartTime.xAxis.labelFont = UIFont.systemFont(ofSize: 16) // 设置 X 轴标签字体大小为16
        setTimeData()
    }
    
    func setDailyData() {
        var dataSets: [LineChartDataSet] = []
        var entries: [ChartDataEntry] = []
        
        for i in 0..<8 {
            let y = arc4random() % 200 + 50
            let entry = ChartDataEntry(x: Double(i), y: Double(y))
            entries.append(entry)
            
            let dataSet = LineChartDataSet(entries: entries, label: "DataSet \(i + 1)")
            // 每個數值上的圓半徑數值
            dataSet.circleRadius = 0
            // 折線會採用 水平貝塞爾曲線進行平滑處理
            dataSet.mode = .horizontalBezier
            dataSet.drawValuesEnabled = false // 禁用数据点的数值显示
            // 關閉點擊後的十字線
            dataSet.highlightEnabled = false
            // 加粗曲線
            dataSet.lineWidth = 5
            
            dataSet.colors = [NSUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)]
            dataSet.drawCirclesEnabled = false // 不绘制数据点的圆圈
            dataSets.append(dataSet)
        }

        let chartData = LineChartData(dataSets: dataSets)
        chartDaily.data = chartData
        // 新增多筆數據
        count1 = 0
        count2 = 0
        count3 = 0
        count4 = 0
        totalCount = 0
        for i in 0..<5 {
            var entries: [ChartDataEntry] = []
            for j in 0..<xValues.count {
                let y = arc4random() % 200 + 50
                if y > 240 {
                    count1 += 1
                } else if y > 180 && y <= 240 {
                    count2 += 1
                } else if y > 70 && y <= 180 {
                    count3 += 1
                } else {
                    count4 += 1
                }
                let entry = ChartDataEntry(x: Double(j), y: Double(y))
                entries.append(entry)
            }
            let dataSet = LineChartDataSet(entries: entries, label: "DataSet \(i + 1)")
            dataSet.circleRadius = 0
            dataSet.mode = .horizontalBezier
            dataSet.drawValuesEnabled = false
            // 设置不同的颜色和填充颜色
            dataSet.colors = [NSUIColor.blue]
            // 设置填充颜色
            dataSet.fillColor = UIColor.tintColor
            dataSet.drawFilledEnabled = true
            dataSet.highlightEnabled = false
            dataSet.lineWidth = 0
            dataSet.drawCirclesEnabled = false
            dataSets.append(dataSet)
        }
        totalCountArr.removeAll()
        totalCountArr.append(count1)
        totalCountArr.append(count2)
        totalCountArr.append(count3)
        totalCountArr.append(count4)
        totalCount = count1 + count2 + count3 + count4
//        print(totalCountArr)
        let chartData2 = LineChartData(dataSets: dataSets)
        chartDaily.data = chartData2
    }
    
    func setTimeData() {
        //生成10条随机数据
        var dataEntries = [BarChartDataEntry]()
        for i in 0..<4 {
            let entry = BarChartDataEntry(x: Double(i), y: Double(totalCountArr[i] / totalCount) * 100)
            dataEntries.append(entry)
        }
        //这20条数据作为柱状图的所有数据
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "图例1")
        chartDataSet.valueFont = UIFont.systemFont(ofSize: 16) // 设置标签字体大小为16
        chartDataSet.colors = [.yellow, .orange, .red, .blue]
        chartDataSet.highlightEnabled = false
        //目前柱状图只包括1组立柱
        let chartData = BarChartData(dataSets: [chartDataSet])
        //设置柱状图数据
        chartTime.data = chartData
    }
    
    func getCurrentDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy" // 设置日期格式
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
    
    func getDateAfterSevenDays(day: Int) -> String {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = day // 设置为七天后

        if let futureDate = calendar.date(byAdding: dateComponents, to: Date()) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            let formattedDate = dateFormatter.string(from: futureDate)
            return formattedDate
        }
        return ""
    }
    
    // MARK: - IBAction
    
    @IBAction func changeType(_ sender: Any) {
        if segmentType.selectedSegmentIndex == 0 {
            chartDaily.isHidden = false
            chartTime.isHidden = true
        } else {
            chartDaily.isHidden = true
            chartTime.isHidden = false
        }
    }
    
    @IBAction func changeDate(_ sender: Any) {
        var selectDay: Int = 0
        if segmentDate.selectedSegmentIndex == 0 {
            currentDates = getCurrentDateFormatted()
            afterDay = getDateAfterSevenDays(day: 7)
            selectDay = 7
        } else if segmentDate.selectedSegmentIndex == 1 {
            currentDates = getCurrentDateFormatted()
            afterDay = getDateAfterSevenDays(day: 14)
            selectDay = 14
        } else if segmentDate.selectedSegmentIndex == 2 {
            currentDates = getCurrentDateFormatted()
            afterDay = getDateAfterSevenDays(day: 30)
            selectDay = 30
        }
        lbDate.text = "\(afterDay) - \(currentDates)"
        lbAvailable.text = "Date available for \(selectDay) of 30 days"
        setDailyData()
        setTimeData()
    }
}
// MARK: - Extension

// MARK: - Protocol


