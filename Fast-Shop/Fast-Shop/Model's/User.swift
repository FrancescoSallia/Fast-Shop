//
//  User.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 29.01.25.
//

import Foundation

class User: ObservableObject, Identifiable {
    let id: UUID = UUID()
    let name: String
    var cart: [Product] //Variablen die sich ändern können, werden mit Published markiert
    var favorite: [Product]
    var email: String
    var password: String
    var adress: String
    var houseNumber: String
    var plz: String
    var location: String
    
    init(name: String, card: [Product] = [], favorite: [Product] = [], email: String = "test@mail.com", password: String = "test123", adress: String = "Musterstraße", houseNumber: String = "12a", plz: String = "12132", location: String = "Berlin") {
        self.name = name
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
