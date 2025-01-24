//
//  errorEnum.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 21.01.25.
//

import Foundation

enum errorEnum: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case noProducts
    case localizedDescription(Error)
}
