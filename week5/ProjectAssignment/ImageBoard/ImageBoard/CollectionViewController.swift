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
        
        if let signInViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") {
            let navigationController = UINavigationController(rootViewController: signInViewController)
            self.present(navigationController, animated:false, completion: nil)
        }
        
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
