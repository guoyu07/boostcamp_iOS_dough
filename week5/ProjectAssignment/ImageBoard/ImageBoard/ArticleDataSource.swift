//
//  ArticleDataSource.swift
//  ImageBoard
//
//  Created by Kangsoo on 01/08/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class ArticleDataSource: NSObject {
    var articles = [Article]()
}

extension ArticleDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCollectionViewCell",
                                                      for: indexPath)
            as? ArticleCollectionViewCell ?? ArticleCollectionViewCell()
        
        return cell
    }
}