//
//  Record.swift
//  OneToTwentyfive
//
//  Created by Kangsoo on 24/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class Record: NSObject, NSCoding {
    var userName: String
    var recordDate: String
    var timeRecord: String
    
    init(_ userName: String, _ recordDate: String, _ timeRecord: String) {
        self.userName = userName
        self.recordDate = recordDate
        self.timeRecord = timeRecord
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.userName = aDecoder.decodeObject(forKey: "userName") as! String
        self.recordDate = aDecoder.decodeObject(forKey: "recordDate") as! String
        self.timeRecord = aDecoder.decodeObject(forKey: "timeRecord") as! String
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userName, forKey: "userName")
        aCoder.encode(recordDate, forKey: "recordDate")
        aCoder.encode(timeRecord, forKey: "timeRecord")
    }
}
