//
//  CorrectModeViewController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/23.
//

import UIKit

import RealmSwift

class CorrectModeViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tbvCorrect: UITableView!
    
    // MARK: - Variables
    
    let correctTitle: [String] = ["RawData2BGBias", "BGBias", "GLow",
                                  "BGHigh","MapRate", "ThresholdRise",
                                  "ThresholdFall", "RiseRate", "FallenRate"]
   
    var storeRawData2BGBias: Int = 0
    
    var storeBGBias: Int = 0
    
    var storeBGLow: Int = 0
    
    var storeBGHigh: Int = 0
    
    var storeMapRate: Int = 0
    
    var storeThresholdRise: Int = 0
    
    var storeThresholdFall: Int = 0
    
    var storeRiseRate: Int = 0
    
    var storeFallenRate: Int = 0
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        setupCorrectData()
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
        tbvCorrect.register(UINib(nibName: "CorrectTableViewCell", bundle: nil),
                            forCellReuseIdentifier: CorrectTableViewCell.identifier)
        tbvCorrect.delegate = self
        tbvCorrect.dataSource = self
    }
    
    func setupNavigation() {
        let rightButtonItem = UIBarButtonItem(title: "儲存", style: .plain, target: self, action: #selector(saveCorrectData))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    func setupCorrectData() {
        let realm = try! Realm()
        let correctData = realm.objects(CalibrationModeData.self)
        // 檢查 correctData 是否包含至少一筆資料
        if correctData.isEmpty {
            try! realm.write {
                realm.add(CalibrationModeData(RawData2BGBias: 100,
                                              BGBias: 100,
                                              GLow: 40,
                                              BGHigh: 400,
                                              mapRate: 1,
                                              thresholdRise: 50,
                                              thresholdFall: 50,
                                              riseRate: 100,
                                              fallenRate: 100))
            }
        }
        print(realm.configuration.fileURL!)
//        print(Realm.Configuration.defaultConfiguration.fileURL!)

    }
    
    // MARK: - IBAction
    
    @objc func saveCorrectData() {
        let realm = try! Realm()
        let correctData = realm.objects(CalibrationModeData.self)
                
        try! realm.write {
            correctData[0].RawData2BGBias = storeRawData2BGBias
            correctData[0].BGBias = storeBGBias
            correctData[0].GLow = storeBGLow
            correctData[0].BGHigh = storeBGHigh
            correctData[0].mapRate = storeMapRate
            correctData[0].thresholdRise = storeThresholdRise
            correctData[0].thresholdFall = storeThresholdFall
            correctData[0].riseRate = storeRiseRate
            correctData[0].fallenRate = storeFallenRate
        }
    }
    
    @objc func textFieldChange(_ textField: UITextField) {

        if let text = textField.text, let intValue = Int(text), textField.tag == 0 {
            // 成功解包 text 並成功轉換為整數
            storeRawData2BGBias = intValue
        }
        
        if let text = textField.text, let intValue = Int(text), textField.tag == 1 {
            storeBGBias = intValue
        }

        if let text = textField.text, let intValue = Int(text), textField.tag == 2 {
            storeBGLow = intValue
        }

        if let text = textField.text, let intValue = Int(text), textField.tag == 3 {
            storeBGHigh = intValue
        }

        if let text = textField.text, let intValue = Int(text), textField.tag == 4 {
            storeMapRate = intValue
        }

        if let text = textField.text, let intValue = Int(text), textField.tag == 5 {
            storeThresholdRise = intValue
        }

        if let text = textField.text, let intValue = Int(text), textField.tag == 6 {
            storeThresholdFall = intValue
        }

        if let text = textField.text, let intValue = Int(text), textField.tag == 7 {
            storeRiseRate = intValue
        }

        if let text = textField.text, let intValue = Int(text), textField.tag == 8 {
            storeFallenRate = intValue
        }
    }
}
// MARK: - Extension

extension CorrectModeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // 每個cell 的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    // 每個header 的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "校正模式"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvCorrect.dequeueReusableCell(withIdentifier: CorrectTableViewCell.identifier, for: indexPath) as! CorrectTableViewCell
        
        cell.lbTitle.text = correctTitle[indexPath.row]
        cell.txfInput.tag = indexPath.row
        cell.txfInput.addTarget(self,
                                action: #selector(textFieldChange(_:)),
                                for: .editingChanged)
        
        cell.txfInput.delegate = self
        
        let realm = try! Realm()
        let correctData = realm.objects(CalibrationModeData.self)
        
        switch indexPath.row {
        case 0:
            cell.txfInput.text = String(correctData[0].RawData2BGBias)
            storeRawData2BGBias = Int(cell.txfInput.text!)!
        case 1:
            cell.txfInput.text = String(correctData[0].BGBias)
            storeBGBias = Int(cell.txfInput.text!)!
        case 2:
            cell.txfInput.text = String(correctData[0].GLow)
            storeBGLow = Int(cell.txfInput.text!)!
        case 3:
            cell.txfInput.text = String(correctData[0].BGHigh)
            storeBGHigh = Int(cell.txfInput.text!)!
        case 4:
            cell.txfInput.text = String(correctData[0].mapRate)
            storeMapRate = Int(cell.txfInput.text!)!
        case 5:
            cell.txfInput.text = String(correctData[0].thresholdRise)
            storeThresholdRise = Int(cell.txfInput.text!)!
        case 6:
            cell.txfInput.text = String(correctData[0].thresholdFall)
            storeThresholdFall = Int(cell.txfInput.text!)!
        case 7:
            cell.txfInput.text = String(correctData[0].riseRate)
            storeRiseRate = Int(cell.txfInput.text!)!
        default:
            cell.txfInput.text = String(correctData[0].fallenRate)
            storeFallenRate = Int(cell.txfInput.text!)!
        }
        return cell
    }
}

extension CorrectModeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
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
// MARK: - Protocol


