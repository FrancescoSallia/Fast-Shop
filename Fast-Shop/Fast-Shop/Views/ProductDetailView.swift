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
    @State var showAlert: Bool = false

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
            if showAlert {
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(width: 420, height: 50)
                            .foregroundStyle(.green)
                        
                        Text("Zum Warenkorb hinzufügen")
                            .foregroundStyle(.white)
                            .padding(.trailing, 70)
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .offset(x: -165)
                            .foregroundStyle(.white)
                        Button("Ansehen"){
                            
                        }
                        .bold()
                        .offset(x: 145)
                        .tint(.white)
                    }
//                    .toolbar(content: {
//                        ToolbarItem(placement: .topBarTrailing) {
//                            Button {
//                                //
//                            } label:{
//                                Image(systemName: "square.and.arrow.up")
//                            }
//                            .foregroundStyle(.primary)
//                        }
//                        ToolbarItem(placement: .topBarTrailing) {
//                            ZStack {
//                                Button {
//                                    //
//                                } label:{
//                                    Image(systemName: "bag")
//                                }
//                                .foregroundStyle(.primary)
//                                
//                                Text("\(viewModel.user.cart.count == 0 ? "" : "\(viewModel.user.cart.count)")")
//                                    .font(.footnote)
//                                    .offset(x: 3, y: 1)
//                                    .foregroundStyle(.primary)
//                            }
//                        }
//                    })
                }
                .animation(.easeInOut, value: showAlert)
            }
            HStack() {
                ZStack {
                    Rectangle()
                        .frame(width: 300, height: 50)
                    
                    Button("HINZUFÜGEN") {
                        let addNewCartProduct = Product(id: product.id, title: product.title, price: product.price, description: product.description, images: product.images, category: product.category, isFavorite: true, size: nil, numberOfProducts: 1)
                        
                        if let index = viewModel.user.cart.firstIndex(where: { $0.id == addNewCartProduct.id }) {
//                            viewModel.user.cart.removeAll(where: { $0.id == addNewCartProduct.id })
                            viewModel.user.cart[index].numberOfProducts? += 1
                            Task {
                                try await viewModel.getProductsFromAPI()
                            }
                            
                        } else {
                            viewModel.user.cart.append(addNewCartProduct)
                            Task {
                                try await viewModel.getProductsFromAPI()
                            }
                        }
                        
                        withAnimation {
                            showAlert.toggle()
                        }
                        Task {
                            try await Task.sleep(for: .seconds(3))
                            withAnimation {
                                showAlert = false
                            }
                        }
                    }
                    .tint(.white)
                }
                
                ZStack {
                    Rectangle()
                        .frame(width: 50, height: 50)
                    Button {
                        let addNewFavoriteProduct = Product(id: product.id, title: product.title, price: product.price, description: product.description, images: product.images, category: product.category, isFavorite: true, size: nil
                        )
                        if viewModel.user.favorite.contains(where: { $0.id == addNewFavoriteProduct.id }) {
                            viewModel.user.favorite.removeAll(where: { $0.id == addNewFavoriteProduct.id })
                        } else {
                            viewModel.user.favorite.append(addNewFavoriteProduct)
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
    }
}
#Preview {
    ProductDetailView(product: ProductViewModel().testProduct, viewModel: ProductViewModel())
}
