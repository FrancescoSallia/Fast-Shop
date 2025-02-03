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
    
    init(name: String, card: [Product] = [], favorite: [Product] = [], email: String = "test@mail.com", password: String = "test123") {
        self.name = name
        self.cart = card
        self.favorite = favorite
        self.email = email
        self.password = password
    }
}
