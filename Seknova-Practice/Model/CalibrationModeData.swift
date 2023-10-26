//
//  CalibrationModeData.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/24.
//

import Foundation

import RealmSwift

class CalibrationModeData: Object {
//    @Persisted(primaryKey: true) var Userid: ObjectId
    @Persisted var ModeID: Int
    
    @Persisted var RawData2BGBias: Int = 100
    
    @Persisted var BGBias: Int = 100
    
    @Persisted var GLow: Int = 40
    
    @Persisted var BGHigh: Int = 400
    
    @Persisted var mapRate: Int = 1
    
    @Persisted var thresholdRise: Int = 50
    
    @Persisted var thresholdFall: Int = 50
    
    @Persisted var riseRate: Int = 100
    
    @Persisted var fallenRate: Int = 100
    
//    override static func primaryKey() -> String?{
//        return "uuid"
//    }
    convenience init(RawData2BGBias: Int,
                     BGBias: Int,
                     GLow: Int,
                     BGHigh: Int,
                     mapRate: Int,
                     thresholdRise: Int,
                     thresholdFall: Int,
                     riseRate: Int,
                     fallenRate: Int) {
        self.init()
        self.ModeID = Int.random(in: 0...100) // 這裡可以根據你的需求調整隨機範圍
        self.RawData2BGBias = RawData2BGBias
        self.BGBias = BGBias
        self.GLow = GLow
        self.BGHigh = BGHigh
        self.mapRate = mapRate
        self.thresholdRise = thresholdRise
        self.thresholdFall = thresholdFall
        self.riseRate = riseRate
        self.fallenRate = fallenRate
    }
        
}

struct CalibrationModeDataModel {
    
    var RawData2BGBias: Int = 100
    
    var BGBias: Int = 100
    
    var GLow: Int = 40
    
    var BGHigh: Int = 400
    
    var mapRate: Int = 1
    
    var thresholdRise: Int = 50
    
    var thresholdFall: Int = 50
    
    var riseRate: Int = 100
    
    var fallenRate: Int = 100
}

