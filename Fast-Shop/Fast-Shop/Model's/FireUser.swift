//
//  User.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 29.01.25.
//

import Foundation
import FirebaseFirestore

class FireUser: ObservableObject, Codable, Identifiable {
    @DocumentID var id: String?
    let firstName: String
    let secondName: String
    var cart: [Product]
    var favorite: [Product]
    var email: String
    var password: String
    var adress: String
    var houseNumber: String
    var plz: String
    var location: String
    
    init(firstName: String, secondName: String, card: [Product] = [], favorite: [Product] = [], email: String = "test@mail.com", password: String = "test123", adress: String = "Musterstraße", houseNumber: String = "12a", plz: String = "12132", location: String = "Berlin") {
        self.firstName = firstName
        self.secondName = secondName
        self.cart = card
        self.favorite = favorite
        self.email = email
        self.password = password
        self.adress = adress
        self.houseNumber = houseNumber
        self.plz = plz
        self.location = location
    }
}
