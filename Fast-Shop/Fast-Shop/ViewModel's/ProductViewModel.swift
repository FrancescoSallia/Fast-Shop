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
    @Published var filteredCategory: [Product] = []
    @Published var searchedProducts: [Product] = []
    @Published var filteredID: String = "0"
    @Published var searchedText: String = ""
    @Published var showSheet: Bool = false
    @Published var selectedProduct: Product? = nil
    
    //Filter sheet
    @Published var minPrice = 10.0
    @Published var maxPrice = 100.0
    @Published var beispielArray: [CGFloat] = [0.0, 100.0]
    @Published var selectedCategory : FilteredEnum = .allCategories


    
    //MARK: API Calls
    func getProductsFromAPI() async throws {
        self.products = try await client.getProducts()
    }
    func getCategoriesFromAPI() async throws {
        self.categories = try await client.getCategories()
    }
    func getCategorieFilteredFromAPI() async throws {
        if searchedText.isEmpty{
            self.filteredCategory = try await client.getCategorieFiltered(id: filteredID)
            try await getCategorieFilteredFromAPI()
        } else {
            try await searchTitle()
        }
    }
   private func searchTitle() async throws {
        self.filteredCategory = try await client.searchTitle(title: searchedText)
        try await searchTitle()
    }
    func minMaxPriceFiltered() async throws {
        self.filteredCategory = try await client.minMaxPriceFiltered(preisArray: beispielArray, selectedCategory: selectedCategory)
    }
    
}
