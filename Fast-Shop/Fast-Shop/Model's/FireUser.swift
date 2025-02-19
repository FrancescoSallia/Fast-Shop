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
    var email: String
    var adress: Adress?
    
    init(email: String, adress: Adress? = nil) {
        self.email = email
        self.adress = adress
    }
}
