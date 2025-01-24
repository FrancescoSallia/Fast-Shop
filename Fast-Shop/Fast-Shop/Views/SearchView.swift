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
    //    @State var categories: [Category] = []
    @StateObject var viewModel = ProductViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    
    
    var body: some View {
        NavigationStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.categories) { index in
                        Button("\(index.name)") {
                            viewModel.filteredID = String(index.id)
                        }
                        .font(.title3)
                        .padding()
                        .tint(.primary)
                        
                    }
                }
                Divider()
            }
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(viewModel.filteredCategory) { filteredProduct in
                        LazyVGrid(columns: columns) {
                            
                            AsyncImage(url: URL(string: filteredProduct.images[0])) { pic in
                                pic
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .frame(width: 150, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Text("\(filteredProduct.title)")
                            
                        }
                    }
                }
            }
            .refreshable {
                Task {
                    try await viewModel.getCategorieFilteredFromAPI()
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: "Search")
        .onAppear {
            Task{
                try await viewModel.getCategoriesFromAPI()
                try await viewModel.getCategorieFilteredFromAPI()
            }
        }
    }

    
    
//    func getCategories() async throws {
//        guard let url = URL(string: "https://api.escuelajs.co/api/v1/categories") else {
//           throw errorEnum.invalidURL
//        }
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let categoriesData = try JSONDecoder().decode([Category].self, from: data)
//            self.categories = categoriesData
//        } catch {
//            print(errorEnum.localizedDescription)
//        }
//        
//    }
    
//    func getCategorieFiltered(id: Int) async throws {
//        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products/?categoryId=\(id)") else {
//           throw errorEnum.invalidURL
//        }
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let categoriesData = try JSONDecoder().decode([Category].self, from: data)
//            self.categories = categoriesData
//        } catch {
//            print(errorEnum.localizedDescription)
//        }
//        
//    }
}
#Preview {
    SearchView()
}
