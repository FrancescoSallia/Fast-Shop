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
            "https://i.imgur.com/76HAxcA.jpeg",
        ],
        category: Category(
            id: 1,
            name: "Tools",
            image: "tools.png",
            creationAt: "2025-01-24T08:29:50.000Z",
            updatedAt: "2025-01-24T09:42:00.000Z"
        ), isFavorite: false,
        size: "",
        numberOfProducts: 0)
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var viewModelFirestore: FirestoreViewModel
    @ObservedObject var errorHandler: ErrorHandler = .shared

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.categories) { index in
                            Button {
                                
                                viewModel.filteredID = String(index.id)
                                Task {
                                    try await viewModel
                                        .getCategorieFromID(filterID: viewModel.filteredID)
                                }
                            } label: {
                                if viewModel.filteredID == "0" {
                                    Text("\(index.name)")
                                } else if viewModel.filteredID
                                    == String(index.id)
                                {
                                    Text("\(index.name)")
                                        .underline()
                                } else {
                                    Text("\(index.name)")
                                }
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
                        ForEach(viewModel.products) { filteredProduct in
                            NavigationLink(destination: {
                                ProductDetailView(
                                    product: filteredProduct,
                                    viewModel: viewModel, viewModelFirestore: viewModelFirestore)
                            }) {
                                VStack {
                                    HStack {
                                        ZStack(alignment: .bottom) {
                                            AsyncImage(
                                                url: URL(
                                                    string:
                                                        filteredProduct.images[
                                                            0])
                                            ) { pic in
                                                pic
                                                    .resizable()
                                                    .frame(
                                                        maxWidth: 400,
                                                        maxHeight: 250)
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            Button {
                                                viewModel.selectedProduct =
                                                    filteredProduct
                                                viewModel.showSheet.toggle()
                                            } label: {
                                                Image(
                                                    systemName:
                                                        "plus.circle.fill"
                                                )
                                                .padding(.bottom)
                                                .foregroundStyle(.yellow)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 3)

                                    VStack {
                                        HStack {
                                            Text("\(filteredProduct.title)")
                                                .font(.footnote)
                                            Button {
                                                let addNewFavoriteProduct = Product(
                                                    id: filteredProduct.id,
                                                    title: filteredProduct.title,
                                                    price: filteredProduct.price,
                                                    description: filteredProduct.description,
                                                    images: filteredProduct.images,
                                                    category: filteredProduct.category,
                                                    isFavorite: true,
                                                    size: viewModel.selectedSize
                                                )
                                                
                                                if let index = viewModelFirestore.favoriteList.firstIndex(where: { $0.id == addNewFavoriteProduct.id }) {
//                                                    viewModelFirestore.favoriteList[index].isFavorite?.toggle()
//                                                    viewModel.productIndex = index
                                                   let favItem =  viewModelFirestore.favoriteList[index]
                                                    viewModelFirestore.deleteUserFavorite(product: favItem)
                                                } else {
                                                    viewModelFirestore.updateUserFavorite(product: addNewFavoriteProduct)
                                                }
                                            } label: {
                                                Image(systemName: viewModelFirestore.isProductFavorite(product: filteredProduct) ? "bookmark.fill" : "bookmark")
                                            }
                                        }

                                        HStack {
                                            Text(
                                                "\(filteredProduct.price.formatted())€"
                                            )
                                            .font(.footnote)
                                            .frame(width: 150)
                                            .padding(.bottom, 30)

                                            Spacer()
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                            .tint(.black)
                    }
                }
            }
        .sheet(
            isPresented: $viewModel.showSheet,
            content: {
                SelectedItemSheet(viewModel: viewModel, viewModelFirestore: viewModelFirestore)
                    .presentationDetents([.height(600)])
            }
        )
        .searchable(
            text: $viewModel.searchedText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search..."
        )
        .onChange(
            of: viewModel.searchedText,
            {
                Task {
                   try await viewModel.searchFilterProducts(productList: viewModel.products, searchedText: viewModel.searchedText)
                }
            }
        )
        .onAppear {
            Task {
                try await viewModel.getCategoriesFromAPI()
                try await viewModel.getCategorieFromID(filterID: viewModel.filteredID)
            }
        }
        .alert(isPresented: $errorHandler.showError) {
            Alert(
                title: Text("Error"),
                message: Text(errorHandler.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
      }
    }
  }
}
#Preview {
    SearchView(viewModel: ProductViewModel(), viewModelFirestore: FirestoreViewModel())
}
