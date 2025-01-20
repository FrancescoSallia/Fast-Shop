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
    let price: Int
    let description: String
    let images: [String]
    let category: Category
}
