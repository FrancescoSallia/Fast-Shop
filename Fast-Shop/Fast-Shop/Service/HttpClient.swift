//
//  HttpClient.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 23.01.25.
//

import Foundation


class HttpClient {
    
    
    
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products") else {
            throw errorEnum.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let products = try JSONDecoder().decode([Product].self, from: data)
            return products
        } catch {
            print(error.localizedDescription)
        }
            return []
    }
    func getCategories() async throws -> [Category] {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/categories") else {
           throw errorEnum.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let categoriesData = try JSONDecoder().decode([Category].self, from: data)
            return categoriesData
        } catch {
            print(errorEnum.localizedDescription)
        }
        return []
    }
    func getCategorieFiltered(id: Int) async throws -> [Category] {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products/?categoryId=\(id)") else {
           throw errorEnum.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let categoriesData = try JSONDecoder().decode([Category].self, from: data)
            return categoriesData
        } catch {
            print(errorEnum.localizedDescription)
        }
        return []
    }
}
