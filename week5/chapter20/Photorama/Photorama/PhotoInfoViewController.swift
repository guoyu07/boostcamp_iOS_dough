//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by Kangsoo on 30/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    @IBOutlet var imaageView: UIImageView!
    
    var photo: Photo? {
        didSet {
            navigationItem.title = photo?.title
        }
    }
    var photoStore = PhotoStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photo = self.photo else {
            assertionFailure("The photo is nil.")
            return
        }
        
        photoStore.fetchImageForPhoto(photo: photo) { (result) -> Void in
            switch result {
            case let .success(image):
                OperationQueue.main.addOperation {
                    self.imaageView.image = image
                }
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
}
