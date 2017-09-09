//
//  ItemStore.swift
//  Homepwner
//
//  Created by Kangsoo on 16/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    let itemArchiveURL: URL? = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDirectory = documentsDirectories.first else {
            assertionFailure("The first directory of documents directories is nil.")
            return nil
        }
        
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    init() {
        guard let url = itemArchiveURL else {
            assertionFailure("Failed initializing")
            return
        }
        guard let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: url.path) as? [Item] else {
            assertionFailure("Failed initializing")
            return
        }
        allItems += archivedItems
    }
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        guard fromIndex != toIndex else {
            return
        }
        
        let movedItem = allItems[fromIndex]
        
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }
    
    func saveChanges() -> Bool {
        guard let url = itemArchiveURL else {
            assertionFailure("Failed saving changes")
            return false
        }
        print("Saving items to: \(url.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: url.path)
    }
}
