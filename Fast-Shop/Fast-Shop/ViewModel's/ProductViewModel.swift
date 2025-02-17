//
//  ProductViewModel.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 21.01.25.
//

import Foundation

@MainActor
class ProductViewModel: ObservableObject {
    
    init() {
        getProductsFromAPI()
    }
    
    private let client = HttpClient()
    private let errorHandler = ErrorHandler.shared
    
    var productIndex: Int = 0
    @Published var products: [Product] = []
    @Published var allProductsForHomeView: [Product] = []
    @Published var categories: [Category] = []
    @Published var filteredID: String = "1"
    @Published var searchedText: String = ""
    @Published var showSheet: Bool = false
    @Published var showHomeDetailSheet: Bool = false
    @Published var showLottieSuccessfullView: Bool = false
    @Published var categorieText: String = ""

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

    @Published var selectedSize: String = ""
    @Published var showSizes: Bool = false
    @Published var showClothesSizesOnCart: Bool = false
    @Published var showShoesSizesOnCart: Bool = false

    
    //MARK: Filter Sheet
    @Published var minPrice = 0.0
    @Published var maxPrice = 100.0
    @Published var minMaxValues: [CGFloat] = [0.0, 100.0]
    @Published var selectedCategory : FilteredEnum = .allCategories

    
    //MARK: User
    @Published var user = FireUser(
        email: "Test@test.de", adress: Adress(
            firstName: "John",
            secondName: "Test",
            street: "MusterStraße",
            houseNumber: "2",
            plz: "13335",
            location: "Berlin"
        )
    )
    @Published var selectedPayOption: String = "apple-pay"
    
    //MARK: Cart
    @Published var showCart = true
    
    //MARK: Calender & Delivery
    @Published var selectedDeliveryPrice: String = "0.00"
    @Published var selectedDeliveryOption: Int = 0 // 0 = kostenlos, 1 = kostenpflichtig
    var deliveryCost: Double {
        return Double(selectedDeliveryPrice.replacingOccurrences(of: ",", with: ".")) ?? 0.00
    }
    @Published var showOrderViewSheet: Bool = false
    @Published var showPayOptionViewSheet: Bool = false

    func deliveryDate(daysToAdd: Int) -> String {
        let calendar = Calendar.current
        var date = Date()
        var addedDays = 0

        while addedDays < daysToAdd {
            date = calendar.date(byAdding: .day, value: 1, to: date)! // Einen Tag hinzufügen

            let weekday = calendar.component(.weekday, from: date)
            if weekday != 1 && weekday != 7 { // 1 = Sonntag, 7 = Samstag (keine Lieferung)
                addedDays += 1
            }
        }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE") // Deutsches Format
        dateFormatter.dateFormat = "EEEE, d. MMMM" // Beispiel: "Freitag, 9. Februar"
        return dateFormatter.string(from: date)
    }

    //MARK: API Calls
    
    func getProductsFromAPI() {
        Task {
            do {
                self.products = try await client.getProducts()
                self.allProductsForHomeView = try await client.getProducts()
            } catch {
                print("viewModel Error: \(error)")
                errorHandler.handleError(error: error)
            }
        }
    }
    
    func getCategoriesFromAPI() async throws {
        self.categories = try await client.getCategories()
    }
    
    func getCategorieFromID(filterID: String) async throws {
        self.products = try await client.getCategorieFiltered(id: filteredID)
    }
    
    func searchFilterProducts(productList: [Product], searchedText: String) async throws {
        // Wenn das Suchfeld leer ist, zeige alle Produkte an
        if searchedText.isEmpty {
            self.products = try await client.getCategorieFiltered(id: filteredID)
            return
        }
        
        // Filtere die Produkte nach dem Titel
        self.products = productList.filter { product in
            product.title.lowercased().contains(searchedText.lowercased())
        }
    }
    
 
//    func getProductsFromAPI() async throws {
//        let result = try await client.getProducts(firstIndex: productIndex, lastIndex: 10)
//        self.products.append(contentsOf: result)
//        self.products = try await client.getProducts(firstIndex: productIndex, lastIndex: productIndex + 10)
//        productIndex += 10
//        if result.count == 0 {
//            showProgressView = false
//        }
//    }

//    func getProductsFromAPI() async throws {
//        self.products = try await client.getProducts()
//    }
    
    
//    func getCategorieFilteredFromAPI() async throws {
//        if searchedText.isEmpty && filterIsActive == false {
//            try await getCategorieFromID(filterID: filteredID)
//        } else if filterIsActive == true {
//            try await minMaxPriceFiltered()
//        }
//        else {
//            self.products = try await client.searchTitle(title: searchedText)
//        }
//    }
    
//   func minMaxPriceFiltered() async throws {
//       self.products = try await client.minMaxPriceFiltered(searchText: searchedText, preisArray: minMaxValues, selectedCategory: filteredID)
//    }
    
//    func isLastItem(product: Product) -> Bool {
//        if let index = self.products.lastIndex(where: {$0.id == product.id}) {
//            return index == self.products.count - 1
//        }
//        return false
//    }
  
}
