//
//  RegisterViewController.swift
//  Seknova-Practice
//
//  Created by imac-1682 on 2023/9/12.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var registerBackground: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var registerAcountLabel: UILabel!
    
    @IBOutlet weak var mail: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var againPassword: UITextField!
    
    @IBOutlet weak var countryBTN: UIButton!

    @IBOutlet weak var checkBTN: UIButton!
    
    @IBOutlet weak var privacyBook: UIButton!
    
    @IBOutlet weak var areaPickerView: UIPickerView!
    
    @IBOutlet weak var registerBTN: UIButton!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var consentTextView: UITextView!
    
    // MARK: - Variables
    let country: [String] = ["Taiwan(台灣)", "America(美國)"]
    
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
        view.sendSubviewToBack(registerBackground)
        areaPickerView.delegate = self
        areaPickerView.dataSource = self
        
        // 改變 Label 文字顏色
        titleLabel.textColor = UIColor(red: 194.0 / 255.0,
                                       green: 15.0 / 255.0,
                                       blue: 36.0 / 255.0, alpha: 1.0)
        registerAcountLabel.textColor = UIColor(red: 194.0 / 255.0,
                                                green: 15.0 / 255.0,
                                                blue: 36.0 / 255.0, alpha: 1.0)
        
        setupLeftView(imageName: "mail", for: mail, width: 45, height: 20)
        setupLeftView(imageName: "password", for: password, width: 45, height: 30)
        setupLeftView(imageName: "password", for: againPassword, width: 45, height: 30)

        
        // 設置 註冊按鈕
        registerBTN.layer.cornerRadius = registerBTN.frame.height / 2
        registerBTN.layer.borderWidth = 5.0 // 设置边框宽度
        registerBTN.layer.borderColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                                blue: 36.0 / 255.0, alpha: 1.0).cgColor
        registerBTN.setTitle("註冊", for: .normal)
        registerBTN.tintColor = UIColor(red: 194.0 / 255.0, green: 15.0 / 255.0,
                                      blue: 36.0 / 255.0, alpha: 1.0)
        
        
        // checkBTN
        checkBTN.layer.cornerRadius = checkBTN.frame.width / 2 // 使按钮呈圆形
        checkBTN.backgroundColor = UIColor.blue
        checkBTN.layer.borderWidth = 1.0 // 设置边框宽度
        checkBTN.layer.borderColor = UIColor.gray.cgColor
        
        
        // 增加陰影
        backgroundView.layer.shadowColor = UIColor.gray.cgColor // 設置陰影顏色
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 2) // 設置陰影偏移
        backgroundView.layer.shadowRadius = 4.0 // 設置陰影半徑
        backgroundView.layer.shadowOpacity = 0.9 // 設置陰影透明度
        
        
        
        let textView = UITextView(frame: CGRect(x: 20,
                                                y: 100,
                                                width: view.frame.width * 9 /  10,
                                                height: view.frame.height * 8 /  10))
            textView.text = "这是一个固定内容的UITextView。dasdassssssssssssssssssssssssssssssss"
            textView.isEditable = false // 禁用编辑

            // 创建一个按钮，放在UITextView的下方
        let button = UIButton(frame: CGRect(x: 20, y: 50, width: 100, height: 40))

        button.setTitle("点击按钮", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        // 将UITextView和按钮添加到视图层次结构中
        textView.insertSubview(button, aboveSubview: textView.subviews[0])

        view.addSubview(textView)
    }
    
    @objc func buttonTapped() {
        // 处理按钮点击事件
        print("按钮被点击了！")
    }
    func setupNavigation() {
        title = "Register"
    }
    
    func setupLeftView(imageName: String, for textField: UITextField, width: CGFloat, height: CGFloat) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 25, height: height))
        imageView.image = UIImage(named: imageName)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        leftView.addSubview(imageView)
        
        textField.leftView = leftView
        textField.leftViewMode = .always
    }
   


    // MARK: - IBAction
    @objc func add_BTN() {
        print(1234)
    }
}
// MARK: - Extension
extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return country.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
      titleForRow row: Int, forComponent component: Int)
    -> String? {
        return country[row]
    }
    
    
}
// MARK: - Protocol


