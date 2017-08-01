//
//  User.swift
//  ImageBoard
//
//  Created by Kangsoo on 01/08/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import Foundation

class User {
    var email: String
    var nickname: String
    var password: String
    
    init(email: String, nickname: String, password: String) {
        self.email = email
        self.nickname = nickname
        self.password = password
    }
}
