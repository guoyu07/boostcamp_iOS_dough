//
//  Item.swift
//  Homepwner
//
//  Created by Kangsoo on 16/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name :String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: Date

    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        
        super.init()
    }
	
	// MARK: 이게 좋은 방법일까요?
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
		let randomValue = Int(arc4random_uniform(100))
		let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first
		
		self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
	}
}
