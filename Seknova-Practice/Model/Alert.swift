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
                         action: @escaping (String) -> Void
                        ){
        DispatchQueue.main.async { [self] in
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            for title in titles {
                let action = UIAlertAction(title: title, style: .default) { _ in
                    action(title)
                }
                setButtonColor(action)
                alertController.addAction(action)
            }
            // 添加取消按鈕
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                // 取消按钮点击时的操作（如果需要的话）
            }
            setButtonColor(cancelAction)
            alertController.addAction(cancelAction)
            vc.present(alertController, animated: true)
        }
    }
    
    func setButtonColor(_ action: UIAlertAction) {
        action.setValue(UIColor.mainColor, forKey: "titleTextColor")
    }
}
