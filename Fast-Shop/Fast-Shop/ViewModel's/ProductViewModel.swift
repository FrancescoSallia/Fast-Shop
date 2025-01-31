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
    @Published var filteredID: String = "1"
    @Published var searchedText: String = ""
    @Published var showSheet: Bool = false
    @Published var selectedProduct: Product = Product(
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
        ), isFavorite: false,
        size: "",
        numberOfProducts: 0
    )
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
        ), isFavorite: false,
        size: "",
        numberOfProducts: 0
    )
    
    //MARK: Filter Sheet
    @Published var minPrice = 0.0
    @Published var maxPrice = 100.0
    @Published var minMaxValues: [CGFloat] = [0.0, 100.0]
    @Published var selectedCategory : FilteredEnum = .allCategories
    @Published var showFilterSheet: Bool = false
    @Published var filterIsActive: Bool = false
    
    //MARK: User
    @Published var user = User(name: "John")
    
    //MARK: Cart
    @Published var showCart = true

    
    //MARK: API Calls
    func getProductsFromAPI() async throws {
        self.products = try await client.getProducts()
    }
    func getCategoriesFromAPI() async throws {
        self.categories = try await client.getCategories()
    }
    func getCategorieFilteredFromAPI() async throws {
        if searchedText.isEmpty && filterIsActive == false {
            try await getCategorieFromID(filterID: filteredID)
        } else if filterIsActive == true {
            try await minMaxPriceFiltered()
        }
        else {
            self.products = try await client.searchTitle(title: searchedText)
        }
    }
   func minMaxPriceFiltered() async throws {
       self.products = try await client.minMaxPriceFiltered(searchText: searchedText, preisArray: minMaxValues, selectedCategory: filteredID)
    }
   func getCategorieFromID(filterID: String) async throws {
        self.products = try await client.getCategorieFiltered(id: filteredID)
    }
}
