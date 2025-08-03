//
//  Fast_ShopTests.swift
//  Fast-ShopTests
//
//  Created by Francesco Sallia on 03.08.25.
//

import XCTest
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

}
