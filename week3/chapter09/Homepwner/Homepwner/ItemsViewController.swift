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
        tableView.scrollIndicatorInsets = insets // MARK: 질문: 위로 스크롤하면 상태바랑 겹치는데?
    }
    
    // 표시할 행의 수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    // 각 행에 표시할 내용
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let item = itemStore.allItems[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)" // MARK: 질문: $의 역할은?
        
        return cell
    }
}
