//
//  ProductViewModel.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 21.01.25.
//

import Foundation

@MainActor
class ProductViewModel: ObservableObject {
    
    private let client = HttpClient()
    
    @Published var products: [Product] = []
    @Published var categories: [Category] = []
    @Published var filteredCategory: [Category] = []
    
    
    
    //MARK: API Calls
    func getProductsFromAPI() async throws {
        self.products = try await client.getProducts()
    }
    func getCategoriesFromAPI() async throws {
        self.categories = try await client.getCategories()
    }
    func getCategorieFilteredFromAPI(id: Int) async throws {
        self.filteredCategory = try await client.getCategorieFiltered(id: id)
    }
    
}
