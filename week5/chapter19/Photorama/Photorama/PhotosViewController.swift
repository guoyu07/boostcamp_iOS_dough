//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Kangsoo on 28/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var photoStore = PhotoStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoStore.fetchRecentPhotos() { (photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) recent photos.")
                
                guard let firstPhoto = photos.first else {
                    return
                }
                self.photoStore.fetchImageForPhoto(photo: firstPhoto) { (imageResult) -> Void in
                    switch imageResult {
                    case let .success(image):
                        OperationQueue.main.addOperation {
                            self.imageView.image = image
                        }
                    case let .failure(error):
                        print("Error downloading image: \(error)")
                    }
                }
            case let .failure(error):
                print("Error fetching recent photos: \(error)")
            }
        }
    }
}
