//
//  PhotoStore.swift
//  Photorama
//
//  Created by Kangsoo on 28/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum PhotoError: Error {
    case imageCreationError
}

class PhotoStore {
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchRecentPhotos(completion: @escaping (PhotosResult) -> Void) {
        guard let url = FlickrAPI.recentPhotosURL() else {
            assertionFailure("recentPhotosURL() returned nil.")
            return
        }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            let result = self.processRecentPhotosRequest(data: data, error: error)
            completion(result)
            
            if let httpURLResponse = response as? HTTPURLResponse {
                print(httpURLResponse.statusCode)
                httpURLResponse.allHeaderFields.forEach { headerField in
                    print(headerField)
                }
            }
        }
        task.resume()
    }
    
    func processRecentPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .failure(error!) // MARK: error를 강제언랩핑하지 않는 방법은 없을까?
        }
        return FlickrAPI.photosFromJSONData(data: jsonData)
    }
    
    func fetchImageForPhoto(photo: Photo, completion: @escaping (ImageResult) -> Void) {
        if let image = photo.image {
            completion(.success(image))
            return
        }
        
        let photoURL = photo.remoteURL
        let request = URLRequest(url: photoURL)
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            if case let .success(image) = result {
                photo.image = image
            }
            completion(result)
        }
        task.resume()
    }
    
    func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                if data == nil {
                    return .failure(error!) // MARK: error를 강제언랩핑하지 않는 방법은 없을까?
                } else {
                    return .failure(PhotoError.imageCreationError)
                }
        }
        return .success(image)
    }
}
