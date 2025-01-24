//
//  SearchView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 20.01.25.
//

import SwiftUI

struct SearchView: View {
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
                    LazyVGrid(columns: columns) {
                    ForEach(viewModel.filteredCategory) { filteredProduct in
                            
                            VStack {
                                AsyncImage(url: URL(string: filteredProduct.images[0])) { pic in
                                    pic
                                        .resizable()
                                        .frame(maxWidth: 400, maxHeight: 250)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    
                                } placeholder: {
                                    ProgressView()
                                }
                                .padding(.horizontal,3)
                                
                                VStack{
                                    HStack {
                                        Text("\(filteredProduct.title)")
                                            .font(.footnote)
                                        Image(systemName: "bookmark")
                                    }

                                    HStack {
                                        Text("\(filteredProduct.price.formatted())€")
                                            .font(.footnote)
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                }
                                .padding(.vertical)

                            }
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
        .searchable(text: $viewModel.searchedText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: "Search...")
        .onAppear {
            Task{
                try await viewModel.getCategoriesFromAPI()
                try await viewModel.getCategorieFilteredFromAPI()
                try await viewModel.searchTitle()
            }
        }
        
        
        
        
        
    }
}
#Preview {
    SearchView()
}
