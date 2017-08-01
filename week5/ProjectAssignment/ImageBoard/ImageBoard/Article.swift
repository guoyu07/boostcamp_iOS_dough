//
//  Article.swift
//  ImageBoard
//
//  Created by Kangsoo on 01/08/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

//    "_id": <String : 게시글 id>,
//    "created_at": <Integer : 작성일시 타임스템프>,
//    "thumb_image_url": <String : 섬네일 이미지 하위주소
//    "image_url": <String : 이미지 하위주소>,
//    "author_nickname": <String : 사용자 별명>,
//    "author": <String : 작성자 고유 id>,
//    "image_desc": <String : 이미지 설명>,
//    "image_title": <String : 이미지 제목>,
//    "__v": <String : 서버 API 버전>

import UIKit

class Article {
    
    let id: String
    let thumbImageURL: URL
    let imageTitle: String
    let authorNickname: String
    let dateCreated: Date
    var thumbImage: UIImage?
//    var image: UIImage?
    
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
