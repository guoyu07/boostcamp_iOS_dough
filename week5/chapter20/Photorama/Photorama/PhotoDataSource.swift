//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by Kangsoo on 30/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource {
    var photos = [Photo]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell",
                                                      for: indexPath)
            as? PhotoCollectionViewCell ?? PhotoCollectionViewCell()
        let photo = photos[indexPath.row]
        cell.updateWithImage(image: photo.image)
        
        return cell
    }
}
