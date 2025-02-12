//
//  Adress.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 07.02.25.
//

import Foundation

struct Adress: Codable {
    
    var adressID: String = UUID().uuidString
    let firstName: String
    let secondName: String
    let street: String
    var houseNumber: String
    var plz: String
    var location: String
}
