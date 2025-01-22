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
            ScrollView(.vertical) {
                AsyncImage(url: URL(string: item.images[0])) { pic in
                     pic
                    .resizable()
                    .frame(width: 150, height: 150)
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                } placeholder: {
                    ProgressView()
                }

//                HStack {
//                    ForEach(item.images, id: \.self) { image in
//                        AsyncImage(url: URL(string: image)) { test in
//                            test
//                                .resizable()
//                                .frame(width: 150, height: 150)
//                                .clipShape(RoundedRectangle(cornerRadius: 10))
//                        } placeholder: {
//                            ProgressView()
//                        }
//                    }
//                }
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



