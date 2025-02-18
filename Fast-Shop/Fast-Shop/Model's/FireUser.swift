//
//  User.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 29.01.25.
//

import Foundation
import FirebaseFirestore

class FireUser: Codable, Identifiable {
    @DocumentID var id: String?
//    var cart: [Product] = []
//    var favorite: [Product] = []
    var email: String
//    var password: String
    var adress: Adress?
   
    
    init(email: String, /*password: String = "",*/ adress: Adress? = nil) {
        self.email = email
//        self.password = password
        self.adress = adress
    }
}
