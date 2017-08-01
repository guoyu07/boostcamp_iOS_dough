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
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy 'at' h:mm:ss a"
        return formatter
    }()
    
    func updateWithInfo(image: UIImage?, title: String, nickname: String, date: Date) {
        guard let imageToDisplay = image else {
            imageView.image = nil
            return
        }
        imageView.image = imageToDisplay
        titleTextLabel.text = title
        nicknameTextField.text = nickname
        dateTextField.text = dateFormatter.string(from: date)
    }
}
