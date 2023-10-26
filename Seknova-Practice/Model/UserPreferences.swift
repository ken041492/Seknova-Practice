//
//  UserPreferences.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/27.
//

import Foundation

class UserPreferences {
    
    static let shared = UserPreferences()
    let userPreference: UserDefaults
    
    private init() {
        userPreference = UserDefaults.standard
    }
    
    enum UserPreference: String {
        case userMail
        
        case userpasword
        
        case loginCount
        
        case lowSugarBlood
        
        case highSugarBlood
        
        case deviceID
        
        case scaningID
        
        case isLoggedIn
        
        case isPair
        
        case adcInitValue
        
        case xAxisValue
        
        case yAxisValue
        
        case developStatus
        
        case highLimit
        
        case highAlert
        
        case lowLimit
        
        case lowAlert
        
        case riseAlert
        
        case fallAlert
        
        case isOverride
        
        case bellSetting
        
        case unitChange
        
        case indicateData
        
        case indicateRSSI
        
        case uploadCloud
        
        case overflowAlert
    }
    
    var userMail: String {
        get { return userPreference.string(forKey: UserPreference.userMail.rawValue) ?? "" }
        set { userPreference.set(newValue, forKey: UserPreference.userMail.rawValue)}
    }
    
    var userPassword: String {
        get { return userPreference.string(forKey: UserPreference.userpasword.rawValue) ?? "" }
        set { userPreference.set(newValue, forKey: UserPreference.userpasword.rawValue)}
    }
    
    var loginCount: Int {
        get { return userPreference.integer(forKey: UserPreference.loginCount.rawValue)}
        set { userPreference.set(newValue, forKey: UserPreference.loginCount.rawValue)}
    }
    
    var lowSugarBlood: Int {
        get { return userPreference.integer(forKey: UserPreference.lowSugarBlood.rawValue)}
        set { userPreference.set(newValue, forKey: UserPreference.lowSugarBlood.rawValue)}
    }
    
    var highSugarBlood: Int {
        get { return userPreference.integer(forKey: UserPreference.highSugarBlood.rawValue)}
        set { userPreference.set(newValue, forKey: UserPreference.highSugarBlood.rawValue)}
    }
    
    var deviceID: String {
        get { return userPreference.string(forKey: UserPreference.deviceID.rawValue) ?? "" }
        set { userPreference.set(newValue, forKey: UserPreference.deviceID.rawValue)}
    }
    
    var scaningID: String {
        get { return userPreference.string(forKey: UserPreference.scaningID.rawValue) ?? "" }
        set { userPreference.set(newValue, forKey: UserPreference.scaningID.rawValue)}
    }
    
    var isPair: Bool {
        get { return userPreference.bool(forKey: UserPreference.isPair.rawValue) }
        set { userPreference.set(newValue, forKey: UserPreference.isPair.rawValue)}
    }
    
    var isLoggedIn: Bool {
        get { return userPreference.bool(forKey: UserPreference.isLoggedIn.rawValue) }
        set { userPreference.set(newValue, forKey: UserPreference.isLoggedIn.rawValue)}
    }
    
    var adcInitValue: Int {
        get { return userPreference.integer(forKey: UserPreference.adcInitValue.rawValue)}
        set { userPreference.set(newValue, forKey: UserPreference.adcInitValue.rawValue)}
    }
    var xAxisValue: String {
        get { return userPreference.string(forKey: UserPreference.xAxisValue.rawValue) ?? "3600.0" }
        set { userPreference.set(newValue, forKey: UserPreference.xAxisValue.rawValue)}
    }
    
    var yAxisValue: String {
        get { return userPreference.string(forKey: UserPreference.yAxisValue.rawValue) ?? "400,0" }
        set { userPreference.set(newValue, forKey: UserPreference.yAxisValue.rawValue)}
    }
    
    var developStatus: String {
        get { return userPreference.string(forKey: UserPreference.developStatus.rawValue) ?? "0000" }
        set { userPreference.set(newValue, forKey: UserPreference.developStatus.rawValue)}
    }
    
    var highLimit: String {
        get { return userPreference.string(forKey: UserPreference.highLimit.rawValue) ?? "-" }
        set { userPreference.set(newValue, forKey: UserPreference.highLimit.rawValue)}
    }
    
    var highAlert: Bool {
        get { return userPreference.bool(forKey: UserPreference.highAlert.rawValue) }
        set { userPreference.set(newValue, forKey: UserPreference.highAlert.rawValue)}
    }
    
    var lowLimit: String {
        get { return userPreference.string(forKey: UserPreference.lowLimit.rawValue) ?? "-" }
        set { userPreference.set(newValue, forKey: UserPreference.lowLimit.rawValue)}
    }
    
    var lowAlert: Bool {
        get { return userPreference.bool(forKey: UserPreference.lowAlert.rawValue) }
        set { userPreference.set(newValue, forKey: UserPreference.lowAlert.rawValue)}
    }
    
    var riseAlert: Bool {
        get { return userPreference.bool(forKey: UserPreference.riseAlert.rawValue) }
        set { userPreference.set(newValue, forKey: UserPreference.riseAlert.rawValue)}
    }
    
    var fallAlert: Bool {
        get { return userPreference.bool(forKey: UserPreference.fallAlert.rawValue) }
        set { userPreference.set(newValue, forKey: UserPreference.fallAlert.rawValue)}
    }
    
    var isOverride: Bool {
        get { return userPreference.bool(forKey: UserPreference.isOverride.rawValue) }
        set { userPreference.set(newValue, forKey: UserPreference.isOverride.rawValue)}
    }
    
    var bellSetting: String {
        get { return userPreference.string(forKey: UserPreference.bellSetting.rawValue) ?? "-" }
        set { userPreference.set(newValue, forKey: UserPreference.bellSetting.rawValue)}
    }
    
    var unitChange: Bool {
        get { return userPreference.bool(forKey: UserPreference.unitChange.rawValue) }
        set { userPreference.set(newValue, forKey: UserPreference.unitChange.rawValue)}
    }
    
    var indicateData: Bool {
        get { return userPreference.bool(forKey: UserPreference.indicateData.rawValue) }
        set { userPreference.set(newValue, forKey: UserPreference.indicateData.rawValue)}
    }
    
    var indicateRSSI: Bool {
        get { return userPreference.bool(forKey: UserPreference.indicateRSSI.rawValue) }
        set { userPreference.set(newValue, forKey: UserPreference.indicateRSSI.rawValue)}
    }
    
    var uploadCloud: Bool {
        get { return userPreference.bool(forKey: UserPreference.uploadCloud.rawValue) }
        set { userPreference.set(newValue, forKey: UserPreference.uploadCloud.rawValue)}
    }
    
    var overflowAlert: Bool {
        get { return userPreference.bool(forKey: UserPreference.overflowAlert.rawValue) }
        set { userPreference.set(newValue, forKey: UserPreference.overflowAlert.rawValue)}
    }
}
