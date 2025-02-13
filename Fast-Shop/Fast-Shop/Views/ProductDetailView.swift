//
//  ProductDetailView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 21.01.25.
//

import SwiftUI
import Toast

struct ProductDetailView: View {
    
    let product: Product
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var viewModelFirestore: FirestoreViewModel
    
    let toast = Toast.default(
        image: UIImage(systemName: "checkmark.circle.fill")!,
        imageTint: .systemGreen,
        title: "Zum Warenkorb hinzugefügt",
        config: .init(
            direction: .bottom
        ))

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
                        }
                        else {
                            print("selected ID ANDERE: \(viewModel.selectedProduct.category.id)")
                            
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
                            
                            viewModelFirestore.updateUserCart(product: newProduct)
                            viewModel.showSheet = false
                        }
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
                        if let index = viewModelFirestore.favoriteList.firstIndex(where: { $0.id == addNewFavoriteProduct.id }) {
                            viewModelFirestore.favoriteList[index].isFavorite?.toggle()
                            
                            viewModel.getProductsFromAPI()
                            
                        } else {
//                            viewModel.user.favorite.append(addNewFavoriteProduct)
                            viewModelFirestore.updateUserFavorite(product: addNewFavoriteProduct)
                            
                               viewModel.getProductsFromAPI()
                        }
                    } label: {
                        Image(systemName: product.isFavorite ?? false ? "bookmark.fill" : "bookmark")
                    }
                    .tint(.white)
                }
            }

        }
        .sheet(isPresented: $viewModel.showSizes, content: {
            SizeSheetView(viewModel: viewModel, viewModelFirestore: viewModelFirestore, product: product)
                .presentationDetents([(.medium)])
        })
        .onAppear {
//            Task {
////                try await viewModel.getProductsFromAPI()
//            }
        }
    }

}
#Preview {
    ProductDetailView(product: ProductViewModel().testProduct, viewModel: ProductViewModel(), viewModelFirestore: FirestoreViewModel())
}
