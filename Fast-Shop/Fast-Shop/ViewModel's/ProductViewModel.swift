//
//  ProductViewModel.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 21.01.25.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var products: [Product]?
    
    func getProductsFromAPI() async throws -> [Product] {
        guard products != nil else {
            throw errorEnum.noProducts
        }
        return products ?? []
    }
}
