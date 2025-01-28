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
    @Published var filteredID: String = "0"
    @Published var searchedText: String = ""
    @Published var showSheet: Bool = false
    @Published var selectedProduct: Product? = nil
    @Published var testProduct = Product(
        id: 1,
        title: "Classic Navy Blue Baseball Cap",
        price: 20.0,
        description: "Test Description",
        images: [
        "https://i.imgur.com/R3iobJA.jpeg",
        "https://i.imgur.com/Wv2KTsf.jpeg",
        "https://i.imgur.com/76HAxcA.jpeg"
      ],
        category: Category(
            id: 1,
            name: "Tools",
            image: "tools.png",
            creationAt: "2025-01-24T08:29:50.000Z",
            updatedAt: "2025-01-24T09:42:00.000Z"
        ))
    
    //MARK: Filter sheet
    @Published var minPrice = 0.0
    @Published var maxPrice = 100.0
    @Published var minMaxValues: [CGFloat] = [0.0, 100.0]
    @Published var selectedCategory : FilteredEnum = .allCategories
    @Published var showFilterSheet: Bool = false
    @Published var filterIsActive: Bool = false

    
    //MARK: API Calls
    func getProductsFromAPI() async throws {
        self.products = try await client.getProducts()
    }
    func getCategoriesFromAPI() async throws {
        self.categories = try await client.getCategories()
    }
    func getCategorieFilteredFromAPI() async throws {
        if searchedText.isEmpty {
            self.products = try await client.getCategorieFiltered(id: filteredID)
        } else {
            self.products = try await client.searchTitle(title: searchedText)
        }
    }
   func minMaxPriceFiltered() async throws {
       self.products = try await client.minMaxPriceFiltered(preisArray: minMaxValues, selectedCategory: filteredID)
    }
    
}
