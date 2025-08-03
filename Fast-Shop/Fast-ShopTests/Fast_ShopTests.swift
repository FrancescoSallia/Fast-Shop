//
//  Fast_ShopTests.swift
//  Fast-ShopTests
//
//  Created by Francesco Sallia on 03.08.25.
//

import XCTest
import Combine
@testable import Fast_Shop

final class Fast_ShopTests: XCTestCase {
    
    var viewModel: ProductViewModel!
    
    @MainActor
    override func setUp() {
        super.setUp()
        viewModel = ProductViewModel()
    }
    
    @MainActor
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    @MainActor
    func testInitialSelectedTabIsZero() {
        XCTAssertEqual(viewModel.selectedTab, 0)
    }
    
    @MainActor
    func testDefaultDeliveryCost() {
        viewModel.selectedDeliveryPrice = "3,99"
        XCTAssertEqual(viewModel.deliveryCost, 3.99)
    }
    
    @MainActor
    func testDeliveryDateExcludesWeekends() {
        let result = viewModel.deliveryDate(daysToAdd: 3)
        XCTAssertFalse(result.contains("Samstag") || result.contains("Sonntag"))
    }
    
    @MainActor
    func testGetProductsFromAPI_setsAllProductsForHomeView() {
        let expectation = XCTestExpectation(description: "Wait for Combine to finish")
        let mockClient = MockClient()
        viewModel = ProductViewModel(client: mockClient)
        mockClient.mockProducts = [Product(
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
        )]
        
        // Beobachte das Published-Property
        viewModel.$allProductsForHomeView
            .dropFirst() // skip initial leerer Wert
            .sink { products in
                XCTAssertEqual(products.count, 51)
                XCTAssertEqual(products.first?.title, "Majestic Mountain Graphic T-Shirt")
                expectation.fulfill()
            }
            .store(in: &viewModel.cancellables) // wichtig!
        
        viewModel.getProductsFromAPI() // Aktion auslösen
        
        wait(for: [expectation], timeout: 1.0)
    }
}
