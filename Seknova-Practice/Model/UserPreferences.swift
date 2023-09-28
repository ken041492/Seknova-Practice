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
    }
    
    var userMail: String {
        get { return userPreference.string(forKey: UserPreference.userMail.rawValue) ?? ""}
        set { userPreference.set(newValue, forKey: UserPreference.userMail.rawValue)}
    }
    
    var userPassword: String {
        get { return userPreference.string(forKey: UserPreference.userpasword.rawValue) ?? ""}
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
        get { return userPreference.string(forKey: UserPreference.deviceID.rawValue) ?? ""}
        set { userPreference.set(newValue, forKey: UserPreference.deviceID.rawValue)}
    }
}
