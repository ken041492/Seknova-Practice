//
//  UserInformation.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/9/23.
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
    @Persisted var Smoke: Bool = false
    @Persisted var Check: Bool = false
    @Persisted var Phone_Verified: Bool = false

    override static func primaryKey() -> String?{
        return "uuid"
    }
    
    convenience init(FirstName: String,
                     LastName: String,
                     BirthDay: String,
                     Email: String,
                     Phone: String,
                     Address: String,
                     Gender: String,
                     Height: Int,
                     Weight: Int,
                     Race: String,
                     Liquor: String,
                     Smoke: Bool,
                     Check: Bool,
                     Phone_Verified: Bool) {
        self.init()
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
    var Smoke: Bool = false
    var Check: Bool = false
    var Phone_Verified = false
}
