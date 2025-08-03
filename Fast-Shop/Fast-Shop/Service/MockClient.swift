//
//  MockClient.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 03.08.25.
//

import Foundation
import Combine

class MockClient: APIClientProtocol {
    
    var mockProducts: [Product] = []
    var mockCategories: [Category] = []
    
    func getProducts() -> AnyPublisher<[Product], Error> {
        Just(mockProducts)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getCategories() async throws -> [Category] {
        return mockCategories
    }
    
    func getCategorieFiltered(id: String) async throws -> [Product] {
        return mockProducts.filter { "\($0.category.id)" == id }
    }
    
    func searchTitle(title: String) async throws -> [Product] {
        return mockProducts.filter { $0.title.lowercased().contains(title.lowercased()) }
    }
}
