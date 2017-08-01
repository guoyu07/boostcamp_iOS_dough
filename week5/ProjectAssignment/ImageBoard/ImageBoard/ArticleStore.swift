//
//  ArticleStore.swift
//  ImageBoard
//
//  Created by Kangsoo on 01/08/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum ArticleError: Error {
    case imageCreationError
}

class ArticleStore {
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchAllArticles(completion: @escaping (ArticlesResult) -> Void) {
        guard let url = ImageBoardAPI.allArticlesURL() else {
            assertionFailure("The url is nil.")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            let result = self.processAllArticlesRequest(data: data, error: error)
            completion(result)
            
            if let httpURLResponse = response as? HTTPURLResponse {
                print("Status code: \(httpURLResponse.statusCode)")
            }
        }
        task.resume()
    }
    
    func processAllArticlesRequest(data: Data?, error: Error?) -> ArticlesResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return ImageBoardAPI.articlesFromJSONData(data: jsonData)
    }
    
    func fetchThumbImageForArticle(article: Article, completion: @escaping (ImageResult) -> Void) {
        if let image = article.thumbImage {
            completion(.success(image))
            return
        }
        
        let articleURL = article.thumbImageURL
        let request = URLRequest(url: articleURL)
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            let result = self.processThumbImageRequest(data: data, error: error)
            if case let .success(image) = result {
                article.thumbImage = image
            }
            completion(result)
        }
        task.resume()
    }
    
    func processThumbImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(ArticleError.imageCreationError)
                }
        }
        return .success(image)
    }

}
