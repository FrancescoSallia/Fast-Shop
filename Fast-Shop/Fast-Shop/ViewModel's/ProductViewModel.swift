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
    @Published var minPrice = 0.0
    @Published var maxPrice = 100.0
    @Published var minMaxValues: [CGFloat] = [0.0, 100.0]
    @Published var selectedCategory : FilteredEnum = .allCategories
    @Published var showFilterSheet: Bool = false
    @Published var filterIsActive: Bool = false
    @Published var filteredMinMax: [Product] = []
//    @Published var showMinMaxFilteredList: Bool = false

    
    //MARK: API Calls
    func getProductsFromAPI() async throws {
        self.products = try await client.getProducts()
    }
    func getCategoriesFromAPI() async throws {
        self.categories = try await client.getCategories()
    }
    func getCategorieFilteredFromAPI() async throws {
        if searchedText.isEmpty {
            self.filteredCategory = try await client.getCategorieFiltered(id: filteredID)
            try await getCategorieFilteredFromAPI()
            
        } else if filterIsActive {
            self.filteredMinMax = try await client.minMaxPriceFiltered(preisArray: minMaxValues, selectedCategory: selectedCategory)
            try await minMaxPriceFiltered()
            
        } else {
            try await searchTitle()
        }
    }
   private func searchTitle() async throws {
        self.filteredCategory = try await client.searchTitle(title: searchedText)
        try await searchTitle()
    }
   func minMaxPriceFiltered() async throws {
        self.filteredMinMax = try await client.minMaxPriceFiltered(preisArray: minMaxValues, selectedCategory: selectedCategory)
    }
    
}
