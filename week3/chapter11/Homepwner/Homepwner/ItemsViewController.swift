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
    
    @IBAction func addNewItem(sender: AnyObject) {
        let newItem = itemStore.createItem()
        
        guard let index = itemStore.allItems.index(of: newItem) else { return }
        let indexPath = IndexPath(row: index, section: 0)
    
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    @IBAction func toggleEditingMode(sender: AnyObject) {
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell
			?? ItemCell(style: .default, reuseIdentifier: "ItemCell")
			
        cell.updateLabels()
		
        let item = itemStore.allItems[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
		cell.valueLabel.text = formatDollars(from: item.valueInDollars)
		cell.setBackgroundColor(by: item.valueInDollars)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		
		let item = itemStore.allItems[indexPath.row]
		
		let title = "Delete \(item.name)?"
		let message = "Are you sure you want to delete this item?"
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		alertController.addAction(cancelAction)
		
		let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
			self.itemStore.removeItem(item: item)
			self.tableView.deleteRows(at: [indexPath], with: .automatic)
		})
		alertController.addAction(deleteAction)
		
		present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
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
