//
//  HistoryViewController.swift
//  OneToTwentyfive
//
//  Created by Kangsoo on 23/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet weak var tableView: UITableView!
	
	var recordStore = RecordStore() {
		didSet {
			recordStore.sortRecords()
		}
	}
	
	@IBAction func showBackToHome(_ sender: UIButton) {
		self.navigationController?.popViewController(animated: true)
	}
	
	@IBAction func dismissHistory(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func resetHistory(_ sender: UIButton) {
		recordStore.allRecords.removeAll()
		// 셀도 바로 삭제해야..
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return recordStore.allRecords.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath)
		let record = recordStore.allRecords[indexPath.row]
		
		cell.textLabel?.text = record.timeRecord
		cell.detailTextLabel?.text = "\(record.userName) (\(record.recordDate))"
		
		return cell
	}
}
