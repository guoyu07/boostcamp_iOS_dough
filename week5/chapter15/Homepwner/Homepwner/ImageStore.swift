//
//  ImageStore.swift
//  Homepwner
//
//  Created by Kangsoo on 31/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class ImageStore {
    let cache = NSCache<AnyObject, AnyObject>()
    
    func setImage(image: UIImage, key: String) {
        cache.setObject(image, forKey: key as AnyObject)
        
        let imageURL = imageURLForKey(key: key)
        
        guard let data = UIImagePNGRepresentation(image) else {
            assertionFailure("Failed PNG representation.")
            return
        }
        
        do {
            try data.write(to: imageURL, options: .atomic)
        } catch let writeError {
            print("Error writing the data atomically: \(writeError)")
        }
    }
    
    func imageForKey(key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as AnyObject) as? UIImage {
            return existingImage
        }
        
        let imageURL = imageURLForKey(key: key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as AnyObject)
        return imageFromDisk
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObject(forKey: key as AnyObject)
        
        let imageURL = imageURLForKey(key: key)
        do {
            try FileManager.default.removeItem(at: imageURL)
        } catch let deleteError {
            print("Error removing the image from disk: \(deleteError)")
        }
    }
    
    func imageURLForKey(key: String) -> URL {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
}
