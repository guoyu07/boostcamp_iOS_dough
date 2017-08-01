//
//  Article.swift
//  ImageBoard
//
//  Created by Kangsoo on 01/08/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class Article {
    
    let id: String
    let thumbImageURL: URL
    let imageTitle: String
    let authorNickname: String
    let dateCreated: Date
    var thumbImage: UIImage?
    var image: UIImage?
    
    init(id: String, thumbImageURL: URL, imageTitle: String, authorNickname: String, dateCreated: Date) {
        self.id = id
        self.thumbImageURL = thumbImageURL
        self.imageTitle = imageTitle
        self.authorNickname = authorNickname
        self.dateCreated = dateCreated
    }
}

extension Article: Equatable {}

func == (lhs: Article, rhs: Article) -> Bool {
    return lhs.id == rhs.id
}
