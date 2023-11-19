//
//  MyMarkerView.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/11/16.
//

//import Foundation

import UIKIT
import Charts

class CustomMarkerView: MarkerView {
    private var markerIcon: UIImageView

    init(frame: CGRect, markerIcon: UIImageView) {
        self.markerIcon = markerIcon
        super.init(frame: frame)
        
        addSubview(markerIcon)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
