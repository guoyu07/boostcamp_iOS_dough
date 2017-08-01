//
//  ArticleCollectionViewCell.swift
//  ImageBoard
//
//  Created by Kangsoo on 01/08/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleTextLabel: UILabel!
    @IBOutlet var nicknameTextField: UILabel!
    @IBOutlet var dateTextField: UILabel!
    
    func updateWithImage(image: UIImage?) {
        guard let imageToDisplay = image else {
            imageView.image = nil
            return
        }
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
