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
//                                .foregroundStyle(.red)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .padding(.bottom)
            }
            .padding(.leading)
            //FIXME: Mit den Kleidungen funktioniert das mit einfügen im warenkorb und löschen/favorisieren auch wenn man andere größen eingibt. jetzt muss es nur noch bei den anderen kategorien funktionieren!
            
            if viewModel.selectedProduct.category.id == 1 {
                Text("\(viewModel.selectedProduct.description)")
                    .font(.footnote)
                    .italic()
                    .padding(.bottom)
                    .padding(.horizontal)
                    .frame(maxHeight: 100)
                ClothesSizeSheet(viewModel: viewModel, viewModelFirestore: viewModelFirestore, product: viewModel.selectedProduct)
                
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
            if viewModel.selectedProduct.category.id != 1 , viewModel.selectedProduct.category.id != 4 {
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
                        
////                                        viewModel.selectedProduct = newProduct
//    //                    viewModel.user.cart.append(newProduct)
//                        viewModelFirestore.updateUserCart(product: newProduct)
//                        viewModel.showSheet = false
//                        
//    //                    if viewModel.selectedProduct.category.id == 1 {
//    //                        viewModel.showAlertSuccessfullAdded = true
//    //                    }
                        
                        if let index = viewModelFirestore.cartList.firstIndex(where: { $0.id == newProduct.id && $0.size == newProduct.size }) {
                            var updatedProduct = viewModelFirestore.cartList[index]
                            updatedProduct.numberOfProducts? += 1
//                                viewModelFirestore.cartList[index].numberOfProducts? += 1
                            viewModelFirestore.updateUserCart(product: updatedProduct)

                        } else {
                            viewModelFirestore.updateUserCart(product: newProduct)
                        }
                        viewModel.showSheet = false
                        viewModel.showHomeDetailSheet = false
                    
                        
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
                            viewModelFirestore.favoriteList[index].isFavorite?.toggle()
                            viewModel.productIndex = index
                        } else {
                            viewModelFirestore.updateUserFavorite(product: addNewFavoriteProduct)
                        }
                        viewModel.showSheet = false

                    } label: {
                        
                        Image(systemName: "bookmark")
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
                        viewModelFirestore.favoriteList[index].isFavorite?.toggle()
                        viewModel.productIndex = index
                    } else {
                        viewModelFirestore.updateUserFavorite(product: addNewFavoriteProduct)
                    }
                    viewModel.showSheet = false

                } label: {
                    
                    HStack {
                        Text("Favorite")
                        Image(systemName: "bookmark")
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
    }
}

#Preview {
//    let testProduct = Product(
//        id: 1,
//        title: "Classic Navy Blue Baseball Cap",
//        price: 20.0,
//        description: "Test Description",
//        images: [
//        "https://i.imgur.com/R3iobJA.jpeg",
//        "https://i.imgur.com/Wv2KTsf.jpeg",
//        "https://i.imgur.com/76HAxcA.jpeg"
//      ],
//        category: Category(
//            id: 1,
//            name: "Tools",
//            image: "tools.png",
//            creationAt: "2025-01-24T08:29:50.000Z",
//            updatedAt: "2025-01-24T09:42:00.000Z"
//        )
//        ,size: "",
//        numberOfProducts: 0)

    SelectedItemSheet(viewModel: ProductViewModel())
        
}
