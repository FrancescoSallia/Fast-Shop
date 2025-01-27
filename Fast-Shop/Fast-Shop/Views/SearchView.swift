//
//  SearchView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 20.01.25.
//

import SwiftUI

struct SearchView: View {
    let testProduct = Product(
        id: 1,
        title: "Classic Navy Blue Baseball Cap",
        price: 20.0,
        description: "Test Description",
        images: [
        "https://i.imgur.com/R3iobJA.jpeg",
        "https://i.imgur.com/Wv2KTsf.jpeg",
        "https://i.imgur.com/76HAxcA.jpeg"
      ],
        category: Category(
            id: 1,
            name: "Tools",
            image: "tools.png",
            creationAt: "2025-01-24T08:29:50.000Z",
            updatedAt: "2025-01-24T09:42:00.000Z"
        ))
    @ObservedObject var viewModel = ProductViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var showFilterSheet: Bool = false

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
                    LazyVGrid(columns: columns, spacing: -10) {
                    ForEach(viewModel.filteredCategory) { filteredProduct in
                            VStack {
                                HStack {
                                    ZStack(alignment: .bottom) {
                                        AsyncImage(url: URL(string: filteredProduct.images[0])) { pic in
                                            pic
                                                .resizable()
                                                .frame(maxWidth: 400, maxHeight: 250)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        Button {
                                            viewModel.selectedProduct = filteredProduct
                                            viewModel.showSheet.toggle()
                                        }label: {
                                            Image(systemName: "plus.circle.fill")
                                                .padding(.bottom)
                                                .foregroundStyle(.yellow)
                                        }
                                        
                                    }
                                    
                                }
                                .padding(.horizontal,3)
                                
                                VStack{
                                    HStack {
                                        Text("\(filteredProduct.title)")
                                            .font(.footnote)
                                            //frame machen
                                        Image(systemName: "bookmark")
                                    }

                                    HStack {
                                        Text("\(filteredProduct.price.formatted())€")
                                            .font(.footnote)
                                            .frame(width: 150)
                                            .padding(.bottom, 30)

                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                }
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
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showFilterSheet.toggle()
                    } label:{
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            })
        }
        .sheet(isPresented: $viewModel.showSheet, content: {
            SelectedItemSheetView(productSelected: viewModel.selectedProduct ?? testProduct )
                .presentationDetents([.height(600)])
//                .presentationDetents([.medium, .large])
        })
        .sheet(isPresented: $showFilterSheet, content: {
            FilterSheetView()
                .presentationDetents([.height(600)])
//                .presentationDetents([.medium, .large])
        })
        .searchable(text: $viewModel.searchedText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: "Search...")
        .onAppear {
            Task{
                try await viewModel.getCategoriesFromAPI()
                try await viewModel.getCategorieFilteredFromAPI()
            }
        }
    }
}
#Preview {
    SearchView()
}

