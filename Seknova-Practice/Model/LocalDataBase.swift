//
//  LocalDataBase.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/22.
//

import RealmSwift

class UserInformation: Object {
    
    @Persisted(primaryKey: true) var Userid: ObjectId
    @Persisted var FirstName: String = ""
    @Persisted var LastName: String = ""
    @Persisted var BirthDay: String = ""
    @Persisted var Email: String = ""
    @Persisted var Phone: String = ""
    @Persisted var Address: String = ""
    @Persisted var Gender: String = ""
    @Persisted var Height: Int = 0
    @Persisted var Weight: Int = 0
    @Persisted var Race: String = ""
    @Persisted var Liquor: String = ""
    @Persisted var Smoke: Bool?
    @Persisted var Check: Bool?
    @Persisted var Phone_Verified: Bool?

    override static func primaryKey() -> String?{
        return "uuid"
    }
    
    convenience init(Userid: ObjectId, FirstName: String, LastName: String,
                     BirthDay: String, Email: String, Phone: String,
                     Address: String, Gender: String, Height: Int,
                     Weight: Int, Race: String, Liquor: String,
                     Smoke: Bool? = nil, Check: Bool? = nil, Phone_Verified: Bool? = nil) {
        self.init()
        self.Userid = Userid
        self.FirstName = FirstName
        self.LastName = LastName
        self.BirthDay = BirthDay
        self.Email = Email
        self.Phone = Phone
        self.Address = Address
        self.Gender = Gender
        self.Height = Height
        self.Weight = Weight
        self.Race = Race
        self.Liquor = Liquor
        self.Smoke = Smoke
        self.Check = Check
        self.Phone_Verified = Phone_Verified
    }
}

struct UserInformationStruct {

    var Userid: ObjectId
    var FirstName: String = ""
    var LastName: String = ""
    var BirthDay: String = ""
    var Email: String = ""
    var Phone: String = ""
    var Address: String = ""
    var Gender: String = ""
    var Height: Int = 0
    var Weight: Int = 0
    var Race: String = ""
    var Liquor: String = ""
    var Smoke: Bool?
    var Check: Bool?
    var Phone_Verified: Bool?
}

import RealmSwift

class UserInformation: Object {
    
    @Persisted(primaryKey: true) var Userid: ObjectId
    @Persisted var FirstName: String = ""
    @Persisted var LastName: String = ""
    @Persisted var BirthDay: String = ""
    @Persisted var Email: String = ""
    @Persisted var Phone: String = ""
    @Persisted var Address: String = ""
    @Persisted var Gender: String = ""
    @Persisted var Height: Int = 0
    @Persisted var Weight: Int = 0
    @Persisted var Race: String = ""
    @Persisted var Liquor: String = ""
    @Persisted var Smoke: Bool?
    @Persisted var Check: Bool?
    @Persisted var Phone_Verified: Bool?

    override static func primaryKey() -> String?{
        return "uuid"
    }
    
    convenience init(Userid: ObjectId, FirstName: String, LastName: String,
                     BirthDay: String, Email: String, Phone: String,
                     Address: String, Gender: String, Height: Int,
                     Weight: Int, Race: String, Liquor: String,
                     Smoke: Bool? = nil, Check: Bool? = nil, Phone_Verified: Bool? = nil) {
        self.init()
        self.Userid = Userid
        self.FirstName = FirstName
        self.LastName = LastName
        self.BirthDay = BirthDay
        self.Email = Email
        self.Phone = Phone
        self.Address = Address
        self.Gender = Gender
        self.Height = Height
        self.Weight = Weight
        self.Race = Race
        self.Liquor = Liquor
        self.Smoke = Smoke
        self.Check = Check
        self.Phone_Verified = Phone_Verified
    }
}

struct UserInformationStruct {

    var Userid: ObjectId
    var FirstName: String = ""
    var LastName: String = ""
    var BirthDay: String = ""
    var Email: String = ""
    var Phone: String = ""
    var Address: String = ""
    var Gender: String = ""
    var Height: Int = 0
    var Weight: Int = 0
    var Race: String = ""
    var Liquor: String = ""
    var Smoke: Bool?
    var Check: Bool?
    var Phone_Verified: Bool?

