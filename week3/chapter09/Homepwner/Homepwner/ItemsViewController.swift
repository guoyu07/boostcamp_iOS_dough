//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Kangsoo on 16/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
	var itemStore : ItemStore!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Content Insets
		let statusBarHeight = UIApplication.shared.statusBarFrame.height
		
		let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
		tableView.contentInset = insets
		tableView.scrollIndicatorInsets = insets // Scroll indicator는 스크롤 뷰 우측의 수직 스크롤바
	}
	
	// 표시할 행의 수
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemStore.allItems.count
	}
	
	// 각 행에 표시할 내용
	override func tableView(_ tableView: UITableView,
	                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell", for: indexPath)
		let item = itemStore.allItems[indexPath.row]
		
		cell.textLabel?.text = item.name
		cell.detailTextLabel?.text = formatDollars(from: item.valueInDollars)
		
		return cell
	}
	
	func formatDollars(from value: Int) -> String {
		let currencyFormatter = NumberFormatter()
		currencyFormatter.numberStyle = .currency
		currencyFormatter.locale = Locale(identifier: "en_US")
		
		guard let formattedValue = currencyFormatter.string(from: value as NSNumber) else {
			return "N/A"
		}
		return formattedValue
	}
}
