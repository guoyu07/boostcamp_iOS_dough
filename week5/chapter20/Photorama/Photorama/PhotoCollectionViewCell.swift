//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by Kangsoo on 30/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    func updateWithImage(image: UIImage?) {
        guard let imageToDisplay = image else {
            spinner.startAnimating()
            imageView.image = nil
            return
        }
        spinner.stopAnimating()
        imageView.image = imageToDisplay
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateWithImage(image: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateWithImage(image: nil)
    }
}
