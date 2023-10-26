//
//  BloodImmediateViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/28.
//

import UIKit

import CoreBluetooth

import Charts

class BloodImmediateViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var lbBloodSugar: UILabel!
    
    @IBOutlet weak var myChartView: LineChartView!
    
    @IBOutlet weak var imgvBlueTooth: UIImageView!
    
    @IBOutlet weak var imgvNetwork: UIImageView!
    
    @IBOutlet weak var vMenu: UIView!
    
    // MARK: - Variables
        
    var networkMonitor: NetworkMonitor?

    var centralManager: CBCentralManager!
    
    var judgeNetwork: Bool = false
    
    var judgeBlueTooth: Bool = false
    
    // 判斷網路的計時器
    var timer: Timer?
    // 讓血糖值可以亂數
    var timer2: Timer?

    var dataEntries: [ChartDataEntry] = []
    
    var secondsPassed: Double = 0
    
    var isViewShifted: Bool = false
    
    let originTime = Date().timeIntervalSince1970


    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setChart()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        // 在视图控制器的 viewDidLoad 方法中创建 NetworkMonitor 实例
        networkMonitor = NetworkMonitor()
        // 在需要检查网络连接的地方使用 networkMonitor
        // 例如，你可以在某个按钮点击事件中检查网络连接：
        checkNetworkConnection()
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(randomSugarBlood), userInfo: nil, repeats: true)
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
        UserPreferences.shared.lowSugarBlood = 65
        UserPreferences.shared.highSugarBlood = 200
    }
    func setChart() {
        // 設定x軸
        myChartView.xAxis.labelPosition = .bottom
        myChartView.xAxis.drawGridLinesEnabled = true // 顯示X軸線
        myChartView.xAxis.avoidFirstLastClippingEnabled = true // 不要超出x軸的範圍
        
        myChartView.leftAxis.drawGridLinesEnabled = true // 顯示Y軸線
        myChartView.rightAxis.enabled = false // 不顯示右邊Y軸
        myChartView.rightAxis.drawGridLinesEnabled = true // 顯示Y軸線
        
        myChartView.legend.enabled = false // 不顯示圖例
        myChartView.scaleYEnabled = false // 取消Y轴缩放
        myChartView.highlightPerTapEnabled = false // 取消點擊高亮

        myChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        myChartView.leftAxis.drawLimitLinesBehindDataEnabled = true // 设置限制线绘制在折线图的后面
        
        for i in UserPreferences.shared.lowSugarBlood ... UserPreferences.shared.highSugarBlood {
            let fillLine = ChartLimitLine(limit: Double(i))
            fillLine.lineWidth = 1
            fillLine.lineColor = NSUIColor.ImmediateBlood!.withAlphaComponent(0.5)
            // 将限制线添加到左侧 Y 轴
            myChartView.leftAxis.addLimitLine(fillLine)
        }
    }
    
    @objc func randomSugarBlood() {
        // 生成随机血糖值
        lbBloodSugar.text = "\(Int.random(in: 55..<400))"
        // 將 UserPreferences.shared.yAxisValue 對 逗號分成array
        let components = UserPreferences.shared.yAxisValue.components(separatedBy: ",")
        if components.count == 2 {
            if let firstNumber = Double(components[0]),
                let secondNumber = Double(components[1]) {
                // 設定y軸
                myChartView.leftAxis.axisMaximum = firstNumber
                myChartView.leftAxis.axisMinimum = secondNumber
            }
        }
        // 获取当前时间戳
        let currentTime = Date().timeIntervalSince1970
        // 获取当前时间往后1小时的时间戳
//        let oneHourLater = currentTime + 3600
        let oneHourLater = currentTime + (Double(UserPreferences.shared.xAxisValue) ?? 0.0)
        // 创建数据点并添加到数据集
        let entry = ChartDataEntry(x: currentTime,
                                   y: Double(lbBloodSugar.text!)!)
        dataEntries.append(entry)
        // 更新折线图数据集
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Blood Sugar")
        dataSet.colors = [NSUIColor.red] // 设置折线的颜色
        dataSet.drawCirclesEnabled = true // 显示数据点的圆圈
        dataSet.circleRadius = 2.0  // 设置數據點的半徑
        dataSet.circleColors = [NSUIColor.red] // 设置數據點的圆圈颜色
        dataSet.drawValuesEnabled = false // 显示数据点的值
//            dataSet.drawFilledEnabled = true // 启用填充颜色
        let data = LineChartData(dataSet: dataSet)
        myChartView.data = data
        // 设置 X 轴的范围为从当前时间戳到当前时间往后1小时
        myChartView.xAxis.setLabelCount(6, force: true) //
        myChartView.xAxis.axisMinimum = currentTime - 60
//        myChartView.xAxis.axisMinimum = originTime
        myChartView.xAxis.axisMaximum = oneHourLater
        // 让图表自动滚动显示最新数据
        if currentTime > oneHourLater {
            myChartView.moveViewToX(currentTime - 3600)
        }
        let xAxis = myChartView.xAxis // 获取 X 轴
        xAxis.valueFormatter = ChartXAxisFormatter() // 设置 X 轴的值格式化器
    }
    
    func checkNetworkConnection() {
        if let monitor = networkMonitor {
            // 在此处检查网络连接
            // 你可以根据 monitor 的状态来执行相应的操作
            if monitor.isConnectedToInternet {
                imgvNetwork.image = UIImage(named: "network-check")
                judgeNetwork = true
//                print("设备已连接到互联网")
            } else {
                imgvNetwork.image = UIImage(named: "network-false")
                judgeNetwork = false
//                print("设备未连接到互联网")
            }
        } else {
            // 如果 networkMonitor 为空，则未成功创建
            print("无法检查网络连接，因为 networkMonitor 未初始化")
        }
    }
    // MARK: - IBAction
    
    @objc func checkNetworkTimer() {
        checkNetworkConnection()
    }
}
// MARK: - Extension
extension BloodImmediateViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("蓝牙状态未知")
        case .resetting:
            print("蓝牙状态重置中")
        case .unsupported:
            print("不支持蓝牙")
        case .unauthorized:
            print("蓝牙未授权")
        case .poweredOff:
            imgvBlueTooth.image = UIImage(named: "bluetooth-false")
            judgeBlueTooth = false
            print("蓝牙已关闭")
        case .poweredOn:
            imgvBlueTooth.image = UIImage(named: "bluetooth-check")
            judgeBlueTooth = true
            print("蓝牙已开启")
        @unknown default:
            print("蓝牙状态未知")
        }
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(checkNetworkTimer), userInfo: nil, repeats: true)
    }
}



// MARK: - Protocol
