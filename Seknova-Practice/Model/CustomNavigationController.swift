//
//  CustomNavigationController.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/11/16.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        // 在這裡指定支援的方向
        return .portrait
    }
}
