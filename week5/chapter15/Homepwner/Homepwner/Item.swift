//
//  Item.swift
//  Homepwner
//
//  Created by Kangsoo on 16/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    var name: String
    var serialNumber: String?
    var valueInDollars: Double
    let dateCreated: Date
    let itemKey: String
    
    init(name: String, serialNumber: String?, valueInDollars: Double) {
        self.name = name
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreated = Date()
        self.itemKey = UUID().uuidString
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        guard random else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
            return
        }
        
        let adjectives = ["Fluffy", "Rusty", "Shiny"]
        let nouns = ["Bears", "Spork", "Mac"]
        
        var idx = arc4random_uniform(UInt32(adjectives.count))
        let randomAdjective = adjectives[Int(idx)]
        
        idx = arc4random_uniform(UInt32(nouns.count))
        let randomNoun = nouns[Int(idx)]
        
        let randomName = "\(randomAdjective) \(randomNoun)"
        let randomValue = Double(arc4random_uniform(100))
        let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first
        
        self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(serialNumber, forKey: "serialNumber")
        aCoder.encode(valueInDollars, forKey: "valueInDollars")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(itemKey, forKey: "itemKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard
            let decodedName = aDecoder.decodeObject(forKey: "name") as? String,
            let decodedSerialNumber = aDecoder.decodeObject(forKey: "serialNumber") as? String?,
            let decodedDateCreated = aDecoder.decodeObject(forKey: "dateCreated") as? Date,
            let decodedItemKey = aDecoder.decodeObject(forKey: "itemKey") as? String else {
                assertionFailure("Failed decoding the object.")
                return nil
        }
        
        name = decodedName
        serialNumber = decodedSerialNumber
        valueInDollars = aDecoder.decodeDouble(forKey: "valueInDollars")
        dateCreated = decodedDateCreated
        itemKey = decodedItemKey
        
        super.init()
    }
}
