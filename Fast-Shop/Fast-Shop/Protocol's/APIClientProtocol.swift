//
//  ProductAPIClient.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 03.08.25.
//

import Foundation
import Combine

protocol APIClientProtocol {
  
    func getProducts() -> AnyPublisher<[Product], Error>
    func getCategories() async throws -> [Category]
    func getCategorieFiltered(id: String) async throws -> [Product]
    func searchTitle(title: String) async throws -> [Product]
}
