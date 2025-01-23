//
//  ProductViewModel.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 21.01.25.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    private let client = HttpClient()
    
    @Published var products: [Product] = []
    
    func getProductsFromAPI() async throws -> [Product] {
        try await client.getProducts(product: products)
    }
}
