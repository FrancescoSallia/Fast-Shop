//
//  APITestView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 20.01.25.
//

import SwiftUI

struct APITestView: View {
    
    @State var products: [Product]?
    
    var body: some View {
        
        
        List(products ?? []) { item in
           
            Text("Title: \(item.title)")
                .listRowSeparator(.hidden)
            Text("Category: \(item.category.name)")
                .listRowSeparator(.hidden)

            Text("ImageUrl: \(item.category.image)")
                .listRowSeparator(.hidden)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(item.images, id: \.self) { image in
                        AsyncImage(url: URL(string: image)) { test in
                            test
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
            
            
            AsyncImage(url: URL(string: item.category.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
            }
            
            
        }
        
        
        
        
        .onAppear {
            Task{
                 try await getProducts()
            }
        }
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
#Preview {
    APITestView()
}


enum errorEnum: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
}
