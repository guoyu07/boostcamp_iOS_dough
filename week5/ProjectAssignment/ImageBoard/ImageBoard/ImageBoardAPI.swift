//
//  ImageBoardAPI.swift
//  ImageBoard
//
//  Created by Kangsoo on 01/08/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import Foundation

enum Action: String {
    case getAllArticles = "/"
    case signIn = "/login"
    case signUp = "/user"
    case addArticle = "/image"
    case changeArticle = "/image/:article_id:"
}

enum ArticlesResult {
    case success([Article])
    case failure(Error)
}

enum ImageBoardError: Error {
    case invalidJSONData
}

struct ImageBoardAPI {
    private static let baseURLString = "https://ios-api.boostcamp.connect.or.kr"
    
    static func imageBoardURL(for action: Action) -> URL? {
        guard let url = URL(string: "\(baseURLString)\(action.rawValue)") else {
            assertionFailure("Failed initializing URL from String")
            return nil
        }
        print("Successfully created URL: \(url)")
        return url
    }
    
    static func articlesFromJSONData(data: Data) -> ArticlesResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let articlesArray = jsonObject as? [Any] else {
                    return .failure(ImageBoardError.invalidJSONData)
            }
            
            var finalArticles = [Article]()
            for articleJSON in articlesArray {
                if let article = articleFromJSONObject(json: articleJSON as! [String : AnyObject]) {
                    finalArticles.append(article)
                }
            }
            
            if finalArticles.count == 0 && articlesArray.count > 0 {
                return .failure(ImageBoardError.invalidJSONData)
            }
            return .success(finalArticles)
        } catch let error {
            return .failure(error)
        }
    }
    
    private static func articleFromJSONObject(json: [String: AnyObject]) -> Article? {
        guard
            let id = json["_id"] as? String,
            let thumbImageURLString = json["thumb_image_url"] as? String,
            let thumbImageURL = URL(string: "\(baseURLString)\(thumbImageURLString)"),
            let imageTitle = json["image_title"] as? String,
            let authorNickname = json["author_nickname"] as? String,
            let timeStamp = json["created_at"] as? Int else {
                return nil
        }
        let timeInterval = TimeInterval(Double(timeStamp))
        let dateCreated = Date(timeIntervalSince1970: timeInterval)
        
        return Article(id: id, thumbImageURL: thumbImageURL, imageTitle: imageTitle, authorNickname: authorNickname, dateCreated: dateCreated)
    }
}
