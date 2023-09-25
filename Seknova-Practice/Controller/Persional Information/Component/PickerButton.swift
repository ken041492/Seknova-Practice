//
//  PickerButton.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/20.
//

import UIKit


class PickerButton: UIButton {
    var pickerView: UIPickerView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(showPicker), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addTarget(self, action: #selector(showPicker), for: .touchUpInside)
    }
    
    @objc private func showPicker() {
        guard let pickerView = pickerView else {
            return
        }
        
        let alertController = UIAlertController(title: nil, message: "\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        
        alertController.view.addSubview(pickerView)
        
//        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
        
        if let presentingVC = findViewController() {
            presentingVC.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}
