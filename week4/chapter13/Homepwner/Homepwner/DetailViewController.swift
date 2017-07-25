//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Kangsoo on 22/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
	@IBOutlet var nameField: UITextField!
	@IBOutlet var serialNumberField: UITextField!
	@IBOutlet var valueField: UITextField!
	@IBOutlet var dateLabel: UILabel!
	
	var item = Item() {
		didSet {
			navigationItem.title = item.name
		}
	}
	
	// MARK: 질문: Formatter는 상수로 쓰는게 좋을까? 아니면 함수로 만들어 쓰는게 좋을까?
	let numberFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.minimumFractionDigits = 2
		formatter.maximumFractionDigits = 2
		return formatter
	}()
	
	let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.timeStyle = .none
		return formatter
	}()
	
	@IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
		view.endEditing(true)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		nameField.text = item.name
		serialNumberField.text = item.serialNumber
		valueField.text = numberFormatter.string(from: item.valueInDollars as NSNumber)
		dateLabel.text = dateFormatter.string(from: item.dateCreated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		view.endEditing(true)
		
		item.name = nameField.text ?? ""
		item.serialNumber = serialNumberField.text
		
		guard let valueText = valueField.text,
			let value = numberFormatter.number(from: valueText) else {
				item.valueInDollars = 0
				return
		}
		item.valueInDollars = value.doubleValue
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
