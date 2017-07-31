//
//  FlickrAPI.swift
//  Photorama
//
//  Created by Kangsoo on 28/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import Foundation

enum Method: String {
    case RecentPhotos = "flickr.photos.getRecent"
}

enum PhotosResult {
    case success([Photo])
    case failure(Error)
}

enum FlickrError: Error {
    case invalidJSONData
}

struct FlickrAPI {
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let APIKey = "a6d819499131071f158fd740860a5a88"
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    private static func flickrURL(method: Method, parameters: [String: String]?) -> URL? {
        guard var components = URLComponents(string: baseURLString) else {
            assertionFailure("URL components is nil.")
            return nil
        }
        var queryItems = [URLQueryItem]()
        
        let baseParameters = [
            "method": method.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": APIKey
        ]
        
        for (key, value) in baseParameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParameters = parameters {
            for (key, value) in additionalParameters {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
            components.queryItems = queryItems
        }
        return components.url
    }
    
    static func recentPhotosURL() -> URL? {
        guard let url = flickrURL(method: .RecentPhotos,
                                  parameters: ["extras": "url_h,date_taken"]) else {
            assertionFailure("flickrURL() returned nil.")
            return nil
        }
        return url
    }
    
    static func photosFromJSONData(data: Data) -> PhotosResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard
                let jsonDictionary = jsonObject as? [String: AnyObject],
                let photos = jsonDictionary["photos"] as? [String: AnyObject],
                let photosArray = photos["photo"] as? [[String: AnyObject]] else {
                    return .failure(FlickrError.invalidJSONData)
            }
            
            var finalPhotos = [Photo]()
            for photoJSON in photosArray {
                if let photo = photoFromJSONObject(json: photoJSON) {
                    finalPhotos.append(photo)
                }
            }
            
            if finalPhotos.count == 0 && photosArray.count > 0 {
                return .failure(FlickrError.invalidJSONData)
            }
            return .success(finalPhotos)
        } catch let error {
            return .failure(error)
        }
    }
    
    private static func photoFromJSONObject(json: [String: AnyObject]) -> Photo? {
        guard
            let photoID = json["id"] as? String,
            let title = json["title"] as? String,
            let dateString = json["datetaken"] as? String,
            let photoURLString = json["url_h"] as? String,
            let url = URL(string: photoURLString),
            let dateTaken = dateFormatter.date(from: dateString) else {
                return nil
        }
        return Photo(title: title, remoteURL: url, photoID: photoID, dateTaken: dateTaken)
    }
}
