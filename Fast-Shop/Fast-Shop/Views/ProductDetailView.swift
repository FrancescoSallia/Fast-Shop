//
//  ProductDetailView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 21.01.25.
//

import SwiftUI

struct ProductDetailView: View {
    
    let product: Product
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var viewModelFirestore: FirestoreViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(product.images, id: \.self) { produkt in
                            AsyncImage(url: URL(string: produkt)) { image in
                                image
                                    .resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 400, height: 600)
                        }
                    }
                }
                .scrollTargetBehavior(.paging)
                        ScrollView {
                            VStack(alignment: .leading) {
                                Text(product.title)
                                Text("GRAPHIC - Pants print - red")
                                    .bold()
                                HStack {
                                    Text("\(product.price.formatted())€")
                                        .bold()
                                        .padding(.bottom, 6)
                                    Text("inkl.MwSt.")
                                        .foregroundStyle(.gray)
                                }
//                                HStack() {
//                                    Button("HINZUFÜGEN") {
//                                        withAnimation {
//                                            showAlert.toggle()
//                                        }
//                                        Task {
//                                            try await Task.sleep(for: .seconds(3))
//                                            withAnimation {
//                                                showAlert = false
//                                            }
//                                        }
//                                    }
//                                    .frame(width: 280, height: 45)
//                                    .border(Color.gray)
//                                    .tint(.white)
//                                    .background(Color.primary)
//                                    
//                                    Button {
//                                        let addNewFavoriteProduct = Product(id: product.id, title: product.title, price: product.price, description: product.description, images: product.images, category: product.category, isFavorite: true, size: nil, numberOfProducts: nil)
//                                        if viewModel.user.favorite.contains(where: { $0.id == addNewFavoriteProduct.id }) {
//                                            viewModel.user.favorite.removeAll(where: { $0.id == addNewFavoriteProduct.id })
//                                        } else {
//                                            viewModel.user.favorite.append(addNewFavoriteProduct)
//                                        }
//                                    } label: {
//                                        Image(systemName: product.isFavorite ?? false ? "bookmark.fill" : "bookmark")
//                                    }
//                                    .frame(width: 55, height: 45)
//                                    .border(Color.gray)
//                                    .tint(.white)
//                                    .background(Color.primary)
//                                    .padding(.leading, 12)
//                                }
//                                .padding(.top, 40)
                                
                                Text(product.description)
                                    .padding()
                                
                            }
                            .padding(.horizontal)
                        }
            }
            //Wenn eine Ware zum Warenkorb hinzugefügt wurde, erscheint das Alert
//            if viewModel.showAlertSuccessfullAdded {
//
//            }
            HStack() {
                ZStack {
                    Rectangle()
                        .frame(width: 300, height: 50)
                    
                    //FIXME: das alert zeigt zweimal an bei hinzufügen!
                    Button("HINZUFÜGEN") {
                        if viewModel.selectedProduct.category.id == 1 {
                            viewModel.showSizes = true
                            print("selected ID 1: \(viewModel.selectedProduct.category.id)")
                        } else {
                            print("selected ID ANDERE: \(viewModel.selectedProduct.category.id)")
                            viewModel.showAlertSuccessfullAdded = true
                        }
//                        if viewModel.showAlertSuccessfullAdded {
////                            withAnimation {
////                                viewModel.showAlertSuccessfullAdded.toggle()
////                            }
////                            Task {
////                                try await Task.sleep(for: .seconds(3))
////                                withAnimation {
////                                    viewModel.showAlertSuccessfullAdded = false
////                                }
////                            }
//                        }
                    }
                    .tint(.white)
                }
                
                ZStack {
                    Rectangle()
                        .frame(width: 50, height: 50)
                    Button {
                        let addNewFavoriteProduct = Product(
                            id: product.id,
                            title: product.title,
                            price: product.price,
                            description: product.description,
                            images: product.images,
                            category: product.category,
                            isFavorite: true,
                            size: viewModel.selectedSize
                        )
                        if let index = viewModel.user.favorite.firstIndex(where: { $0.id == addNewFavoriteProduct.id }) {
                            viewModel.user.favorite[index].isFavorite?.toggle()
                            Task {
                                try await viewModel.getProductsFromAPI()
                            }
                        } else {
                            viewModel.user.favorite.append(addNewFavoriteProduct)
                            viewModelFirestore.updateUserFavorite(product: addNewFavoriteProduct)
                            Task {
                                try await viewModel.getProductsFromAPI()
                            }
                        }
                    } label: {
                        Image(systemName: product.isFavorite ?? false ? "bookmark.fill" : "bookmark")
                    }
                    .tint(.white)
                }
//                .buttonBorderShape(.roundedRectangle(radius: 0))
//                .padding()
//                .padding(.horizontal, 5)
//                .border(Color.primary)
            }
//            .padding(.top, 40)

        }
        .sheet(isPresented: $viewModel.showSizes, content: {
            SizeSheetView(viewModel: viewModel, viewModelFirestore: viewModelFirestore, product: product)
                .presentationDetents([(.medium)])
        })
        .sheet(isPresented: $viewModel.showAlertSuccessfullAdded, content: {
            IsSuccessfullSheet(viewModel: viewModel)
                .presentationDetents([.height(60)])
        })
        .onAppear {
            Task {
                try await viewModel.getProductsFromAPI()
            }
        }
    }
}
#Preview {
    ProductDetailView(product: ProductViewModel().testProduct, viewModel: ProductViewModel(), viewModelFirestore: FirestoreViewModel())
}
