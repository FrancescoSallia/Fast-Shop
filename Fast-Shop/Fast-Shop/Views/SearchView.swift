//
//  SearchView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 20.01.25.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State var searchNumber: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    @State var categoriesStrings: [String] = ["Damen", "Herren", "Kinder", "Home", "Beauty"]
    @State var categories: [Category] = []
       

    var body: some View {
        NavigationStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(categories) { index in
                        Button("\(index.name)"){
                         //
                        }
                        .font(.title3)
                        .padding()
                        .tint(.primary)
                    }
                }
                Divider()
                    
                    
            }
            List(categories) { categorie in
                Text("\(categorie.name)")
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: "Search")
        .onAppear {
            Task{
                try await getCategories()
            }
        }
    }
    
    
    
    func getCategories() async throws {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/categories") else {
           throw errorEnum.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let categoriesData = try JSONDecoder().decode([Category].self, from: data)
            self.categories = categoriesData
        } catch {
            print(errorEnum.localizedDescription)
        }
        
    }
    
    func getCategorieFiltered(id: Int) async throws {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products/?categoryId=\(id)") else {
           throw errorEnum.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let categoriesData = try JSONDecoder().decode([Category].self, from: data)
            self.categories = categoriesData
        } catch {
            print(errorEnum.localizedDescription)
        }
        
    }
}
#Preview {
    SearchView()
}
