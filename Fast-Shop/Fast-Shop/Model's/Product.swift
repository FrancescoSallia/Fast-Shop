//
//  Product.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 15.01.25.
//

import Foundation

struct Product: Identifiable, Codable {
    
   
    let id: Int
    let title: String
    let price: Double
    let description: String
    let images: [String]
    let category: Category
    
    var isFavorite: Bool? = false
    let size: String?
    var numberOfProducts: Int? = 1
    var cartID: String? = UUID().uuidString
}






//let id: Int
//let title: String
//let price: Double
//let description: String
//let category: String
//let image: String
//let rating: Rating
