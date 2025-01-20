//
//  Category.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 20.01.25.
//

import Foundation

struct Category: Identifiable, Codable {
    
    let id: Int
    let name: String
    let image: String
    let creationAt: String
    let updatedAt: String
}
