//
//  Alert.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/19.
//

import Foundation
import UIKit

class Alert {
    func showActionSheet(titles: [String],
                         cancelTitle: String,
                         vc: UIViewController,
                         action: @escaping (String) -> Void) {
        DispatchQueue.main.async { [self] in
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            for title in titles {
                let action = UIAlertAction(title: NSLocalizedString(title, comment: ""), style: .default) { _ in
                    action(title)
                }
                setButtonColor(action)
                alertController.addAction(action)
            }
            // 添加取消按鈕
            let cancelAction = UIAlertAction(title: NSLocalizedString(cancelTitle, comment: ""), style: .cancel) { _ in
                // 取消按钮点击时的操作（如果需要的话）
            }
            setButtonColor(cancelAction)
            alertController.addAction(cancelAction)
            vc.present(alertController, animated: true)
        }
    }

    func showAlert(title: String,
                   message: String,
                   vc: UIViewController,
                   okActionHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            okActionHandler?() // 执行传递的闭包，如果存在的话
        }
        alertController.addAction(okAction)
        
        vc.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func showDeviceIDInputAlert(vc: UIViewController,
                                title: String?,
                                message: String?,
                                placeholder: String?,
                                onCancel: (() -> Void)? = nil,
                                onConfirm: ((String) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.placeholder = placeholder
        }

        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { (_) in
            // 在取消按钮被点击时执行的操作
            onCancel?() // 如果有定义 onCancel 闭包，执行它
        }

        alertController.addAction(cancelAction)

        let confirmAction = UIAlertAction(title: NSLocalizedString("Confirm", comment: ""), style: .default) { (_) in
            if let textField = alertController.textFields?.first,
               let inputText = textField.text {
                // 在确认按钮被点击时执行的操作
                onConfirm?(inputText) // 如果有定义 onConfirm 闭包，将用户输入传递给它
            }
        }

        alertController.addAction(confirmAction)

        vc.present(alertController, animated: true, completion: nil)
    }

    
    
    func setButtonColor(_ action: UIAlertAction) {
        action.setValue(UIColor.mainColor, forKey: "titleTextColor")
    }
}
