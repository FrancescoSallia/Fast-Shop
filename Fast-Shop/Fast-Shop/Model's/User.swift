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
    @Published var cart: [Product] //Variablen die sich ändern können, werden mit Published markiert
    @Published var favorite: [Product]
    
    init(name: String, card: [Product] = [], favorite: [Product] = []) {
        self.name = name
        self.cart = card
        self.favorite = favorite
    }
}
