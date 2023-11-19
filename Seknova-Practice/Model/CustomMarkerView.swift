//
//  CustomMarkerView.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/11/16.
//

import UIKit

import Charts

class CustomMarkerView: MarkerView {
    private var markerIcon: UIImageView

    init(frame: CGRect, markerIcon: UIImageView) {
        self.markerIcon = markerIcon
        super.init(frame: frame)
        backgroundColor = .red // 設置背景顏色以驗證 MarkerView 的位置

        addSubview(markerIcon)
        isHidden = false // 確認這一行是否存在

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
