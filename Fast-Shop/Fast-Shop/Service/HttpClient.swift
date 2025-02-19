//
//  HttpClient.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 23.01.25.
//

import Foundation
import SwiftUICore


class HttpClient {

    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "http://localhost:3001/products") else {
//        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products") else {
            throw ErrorEnum.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let products = try JSONDecoder().decode([Product].self, from: data)
            return products
        } catch {
            throw error
        }
    }
    
    func getCategories() async throws -> [Category] {
        guard let url = URL(string: "http://localhost:3001/categories") else {
//        guard let url = URL(string: "https://api.escuelajs.co/api/v1/categories") else {
           throw ErrorEnum.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let categoriesData = try JSONDecoder().decode([Category].self, from: data)
            return categoriesData
        } catch {
            throw error
        }
    }
    
    func getCategorieFiltered(id: String) async throws -> [Product] {
//        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products/?categoryId=\(id)") else {
        guard let url = URL(string: "http://localhost:3001/products?category/id=\(id)") else {
           throw ErrorEnum.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let categoriesData = try JSONDecoder().decode([Product].self, from: data)
            return categoriesData
        } catch {
            throw error
        }
    }
    
    func searchTitle(title: String) async throws -> [Product] {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products/?title=\(title)") else {
            throw ErrorEnum.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let titleSearched = try JSONDecoder().decode([Product].self, from: data)
            return titleSearched
        } catch {
            throw error
        }
    }
}



