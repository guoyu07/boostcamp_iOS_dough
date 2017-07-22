//
//  ItemCell.swift
//  Homepwner
//
//  Created by Kangsoo on 17/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
        let captionFont = UIFont.preferredFont(forTextStyle: .caption1)
        serialNumberLabel.font = captionFont
    }
	
	func setBackgroundColor(by value: Int) {
		var colorArray = [UIColor]()
		colorArray.append(UIColor(red: 182 / 255, green: 215 / 255, blue: 168 / 255, alpha: 1.0))
		colorArray.append(UIColor(red: 234 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1.0))
		
		if value < 50 {
			self.backgroundColor = colorArray[0]
		} else {
			self.backgroundColor = colorArray[1]
		}
	}
}
