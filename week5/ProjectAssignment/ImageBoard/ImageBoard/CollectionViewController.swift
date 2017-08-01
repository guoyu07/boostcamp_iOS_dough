//
//  CollectionViewController.swift
//  ImageBoard
//
//  Created by Kangsoo on 01/08/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout {
    @IBOutlet var collectionView: UICollectionView!
    
    var articleStore = ArticleStore()
    let articleDataSource = ArticleDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = articleDataSource
        
        articleStore.fetchAllArticles { (articlesResult) -> Void in
            OperationQueue.main.addOperation {
                switch articlesResult {
                case let .success(articles):
                    print("Successfully found \(articles.count) all articles.")
                    self.articleDataSource.articles = articles
                case let .failure(error):
                    self.articleDataSource.articles.removeAll()
                    print("Error fetching articles: \(error)")
                }
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let article = articleDataSource.articles[indexPath.row]
        
        articleStore.fetchThumbImageForArticle(article: article) { (result) -> Void in
            OperationQueue.main.addOperation {
                guard let articleIndex = self.articleDataSource.articles.index(of: article) else {
                    assertionFailure("The index of article is nil.")
                    return
                }
                let articleIndexPath = IndexPath(row: articleIndex, section: 0)
                
                if let cell = self.collectionView.cellForItem(at: articleIndexPath) as? ArticleCollectionViewCell {
                    cell.updateWithImage(image: article.thumbImage)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellLength = 0.0
        
        if UIDevice.current.orientation.isPortrait{
            cellLength = Double(collectionView.bounds.width) / 4
        } else if UIDevice.current.orientation.isLandscape {
            cellLength = Double(collectionView.bounds.width) / 8
        }
        
        return CGSize(width: cellLength, height: cellLength)
    }
}
