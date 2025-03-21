//
//  SelectedItemSheetView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 25.01.25.
//

import SwiftUI

struct SelectedItemSheet: View {
    
    @ObservedObject var viewModel = ProductViewModel()
    @ObservedObject var viewModelFirestore = FirestoreViewModel()
    @ObservedObject var errorHandler: ErrorHandler = .shared
    
    let columns = [(GridItem(.flexible())), (GridItem(.flexible()))]
    
    var body: some View {
        VStack {
            Text(viewModel.selectedProduct.title)
                .font(.headline)
                .padding(.top, 50)
                .padding(.horizontal)
            Text("\(viewModel.selectedProduct.price.formatted())€")
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.selectedProduct.images, id: \.self) { product in
                            AsyncImage(url: URL(string: product)) { pic in
                            pic
                                .resizable()
                                .frame(width: 122, height: 180)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .padding(.bottom)
            }
            .padding(.leading)
            
            if viewModel.selectedProduct.category.id == 1,
               !viewModel.selectedProduct.title.lowercased().contains("cap")  {
                
                Text("\(viewModel.selectedProduct.description)")
                    .font(.footnote)
                    .italic()
                    .padding(.bottom)
                    .padding(.horizontal)
                    .frame(maxHeight: 100)
                ClothesSizeSheet(viewModel: viewModel, viewModelFirestore: viewModelFirestore, product: viewModel.selectedProduct)
                
            } else if viewModel.selectedProduct.category.id == 1,
                      viewModel.selectedProduct.title.lowercased().contains("cap") {
                Text("\(viewModel.selectedProduct.description)")
                    .font(.footnote)
                    .italic()
                    .padding(.bottom)
                    .padding(.horizontal)
                    .frame(maxHeight: 100)
                
            } else if viewModel.selectedProduct.category.id == 2{
//                Text("Electronik")
                Text("\(viewModel.selectedProduct.description)")
                    .font(.footnote)
                    .italic()
                    .padding()
            } else if viewModel.selectedProduct.category.id == 3{
//                Text("Möbel")
                Text("\(viewModel.selectedProduct.description)")
                    .font(.footnote)
                    .italic()
                    .padding()

            } else if viewModel.selectedProduct.category.id == 4{
//                Text("Schuhe")
                Text("\(viewModel.selectedProduct.description)")
                    .font(.footnote)
                    .italic()
                    .padding()
                ShoesSizeSheet(viewModel: viewModel, viewModelFirestore: viewModelFirestore, product: viewModel.selectedProduct)

            } else if viewModel.selectedProduct.category.id == 5{
//                Text("Miscellaneous")
                Text("\(viewModel.selectedProduct.description)")
                    .font(.footnote)
                    .italic()
                    .padding()

            } else {
//                Text("Andere Dinge")
                Text("Keine Beschreibung")
                    .font(.footnote)
                    .italic()
                    .padding()
            }
            if viewModel.selectedProduct.category.id != 1 &&
               viewModel.selectedProduct.category.id != 4 ||
               (viewModel.selectedProduct.category.id == 1 &&
               viewModel.selectedProduct.title.lowercased().contains("cap")) {
               
                HStack {
                    Button {
                        let newProduct = Product(
                            id: viewModel.selectedProduct.id,
                            title: viewModel.selectedProduct.title,
                            price: viewModel.selectedProduct.price,
                            description: viewModel.selectedProduct.description,
                            images: viewModel.selectedProduct.images,
                            category: viewModel.selectedProduct.category,
                            isFavorite: false,
                            size: viewModel.selectedSize,
                            numberOfProducts: 1
                        )
                        
                        if let index = viewModelFirestore.cartList.firstIndex(where: { $0.id == newProduct.id && $0.size == newProduct.size }) {
                            var updatedProduct = viewModelFirestore.cartList[index]
                            updatedProduct.numberOfProducts? += 1
                            viewModelFirestore.updateUserCart(product: updatedProduct)

                        } else {
                            viewModelFirestore.updateUserCart(product: newProduct)
                        }
                        viewModel.showSheet = false
                        viewModel.showHomeDetailSheet = false
                        
                    // Toast
                        withAnimation {
                            viewModel.showToastCart = true
                        }
                        
                    } label: {
                        HStack {
                            Text("HINZUFÜGEN")
                            Image(systemName: "cart.fill")
                        }
                        .tint(.white)
                        .padding()
                        .background(.black)
                        .clipShape(.rect(cornerRadius: 4))
                        .padding()
                    }
                    Button {
                        let addNewFavoriteProduct = Product(
                            id: viewModel.selectedProduct.id,
                            title: viewModel.selectedProduct.title,
                            price: viewModel.selectedProduct.price,
                            description: viewModel.selectedProduct.description,
                            images: viewModel.selectedProduct.images,
                            category: viewModel.selectedProduct.category,
                            isFavorite: true,
                            size: viewModel.selectedSize
                        )
                        if let index = viewModelFirestore.favoriteList.firstIndex(where: { $0.id == addNewFavoriteProduct.id }) {
                            
                            let favItem =  viewModelFirestore.favoriteList[index]
                             viewModelFirestore.deleteUserFavorite(product: favItem)
                            viewModel.showToastFavoriteRemoved.toggle()

                        } else {
                            viewModelFirestore.updateUserFavorite(product: addNewFavoriteProduct)
                            viewModel.showToastFavorite.toggle()
                        }
                        viewModel.showSheet = false

                    } label: {
                        Image(systemName: viewModelFirestore.isProductFavorite(product: viewModel.selectedProduct) ? "bookmark.fill" : "bookmark")
                        .tint(.white)
                        .padding()
                        .background(.black)
                        .clipShape(.rect(cornerRadius: 4))
                    }
                }
            } else {
                Button {
                    let addNewFavoriteProduct = Product(
                        id: viewModel.selectedProduct.id,
                        title: viewModel.selectedProduct.title,
                        price: viewModel.selectedProduct.price,
                        description: viewModel.selectedProduct.description,
                        images: viewModel.selectedProduct.images,
                        category: viewModel.selectedProduct.category,
                        isFavorite: true,
                        size: viewModel.selectedSize
                    )
                    if let index = viewModelFirestore.favoriteList.firstIndex(where: { $0.id == addNewFavoriteProduct.id }) {
                        
                        let favItem =  viewModelFirestore.favoriteList[index]
                         viewModelFirestore.deleteUserFavorite(product: favItem)
                    } else {
                        viewModelFirestore.updateUserFavorite(product: addNewFavoriteProduct)
                    }
                    viewModel.showSheet = false

                } label: {
                    HStack {
                        Text("Favorite")
                        Image(systemName: viewModelFirestore.isProductFavorite(product: viewModel.selectedProduct) ? "bookmark.fill" : "bookmark")
                    }
                    .tint(.white)
                    .padding()
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 4))
                    .frame(maxWidth: .infinity)
                    .padding()
                }
            }
        }
        .onAppear {
            Task {
                try await viewModel.getCategorieFromID(filterID: "\(viewModel.selectedProduct.id)")
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

#Preview {

    SelectedItemSheet(viewModel: ProductViewModel())
        
}
