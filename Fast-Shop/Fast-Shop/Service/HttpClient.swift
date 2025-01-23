//
//  HttpClient.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 23.01.25.
//

import Foundation


class HttpClient {
    
    
    func getProducts(product: [Product]) async throws -> [Product] {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products") else {
            throw errorEnum.invalidURL
        }
       
        do {
            var test = product
            let (data, _) = try await URLSession.shared.data(from: url)
            test = try JSONDecoder().decode([Product].self, from: data)
            return test
        } catch {
            print(error)
        }
        return []
    }
    
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products") else {
            throw errorEnum.invalidURL
        }
       
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            products = try JSONDecoder().decode([Product].self, from: data)
        } catch {
            print(error)
        }
        return []
    }
}
