//
//  Event.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/11/1.
//
import RealmSwift

class Event: Object {
    @Persisted var ID: Int
    
    @Persisted var DateTime: String = ""
    
    @Persisted var DisplayTime: String = ""
    
    @Persisted var EventAttribute: List<String> = List<String>()
    
    @Persisted var EventId: Int = 400
    
    @Persisted var EventValue: Int = 1
    
    @Persisted var Note: String = ""
    
    @Persisted var Check: Bool = false
    
    convenience init(ID: Int,
                     DateTime: String,
                     DisplayTime: String,
                     EventAttribute: List<String>,
                     EventId: Int,
                     EventValue: Int,
                     Note: String,
                     Check: Bool) {
        self.init()
        self.ID = ID
        self.DateTime = DateTime
        self.DisplayTime = DisplayTime
        self.EventAttribute = EventAttribute
        self.EventId = EventId
        self.EventValue = EventValue
        self.Note = Note
        self.Check = Check
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Event.self).max(ofProperty: "ID") as Int? ?? 0) + 1
    }
}

struct EventStruct {
    var ID: Int = 0
    var DateTime: String = ""
    var DisplayTime: String = ""
    var EventAttribute: List<String> = List<String>()
    var EventId: Int = 0
    var EventValue: Int = 0
    var Note: String = ""
    var Check: Bool = false
}
