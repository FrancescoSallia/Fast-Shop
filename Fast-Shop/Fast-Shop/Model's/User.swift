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
    @Published var card: [Product] // Markiere das Array als @Published
    @Published var favorite: [Product] // Markiere das Array als @Published
    
    init(name: String, card: [Product] = [], favorite: [Product] = []) {
        self.name = name
        self.card = card
        self.favorite = favorite
    }
}
