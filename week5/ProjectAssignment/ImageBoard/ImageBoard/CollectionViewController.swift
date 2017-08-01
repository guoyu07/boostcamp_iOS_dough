//
//  CollectionViewController.swift
//  ImageBoard
//
//  Created by Kangsoo on 01/08/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    var articleStore = ArticleStore()
    let articleDataSource = ArticleDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = articleDataSource
        loadArticles()
    }
    
    private func loadArticles() {
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
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let article = articleDataSource.articles[indexPath.row]
        
        articleStore.fetchThumbImageForArticle(article: article) { (result) -> Void in
            OperationQueue.main.addOperation {
                guard let articleIndex = self.articleDataSource.articles.index(of: article) else {
                    assertionFailure("The index of article is nil.")
                    return
                }
                
                let articleIndexPath = IndexPath(row: articleIndex, section: 0)
                
                if let cell = self.collectionView.cellForItem(at: articleIndexPath)
                    as? ArticleCollectionViewCell {
                    cell.updateWithInfo(image: article.thumbImage, title: article.imageTitle,
                                        nickname: article.authorNickname, date: article.dateCreated)
                }
            }
        }
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((Double(collectionView.bounds.width) / 2 - 12.0))
        let height = (width * 1.5)
        return CGSize(width: width, height: height)
    }
}
