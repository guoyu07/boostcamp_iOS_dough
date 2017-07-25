//
//  RecordStore.swift
//  OneToTwentyfive
//
//  Created by Kangsoo on 25/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class RecordStore {
	var allRecords = [Record]()
	
	func sortRecords(){
		allRecords.sort(by: { $0.timeRecord < $1.timeRecord
		})
	}
}
