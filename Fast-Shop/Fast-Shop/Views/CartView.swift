//
//  CardView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 28.01.25.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var viewModelFirestore: FirestoreViewModel
    @State var sizes: [String] = ["XS", "S", "M", "L", "XL", "XXL"]
    //    @State var counter = 0
    //    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let columns = [GridItem(.fixed(400.0))]

    var body: some View {
        NavigationStack {
            HStack {
                Button(
                    "EINKAUFSKORB\(viewModel.user.cart.count == 0 ? "" : "(\(viewModel.user.cart.count))")"
                ) {
                    viewModel.showCart = true
                }
                .font(.footnote)
                .frame(maxWidth: .infinity, maxHeight: 4)
                .padding()
                //                .padding(.horizontal, 35)
                .border(.black)
                .background(viewModel.showCart ? Color.black : Color.white)
                .tint(viewModel.showCart ? .white : .black)
                //                .padding(.leading, -20)
                //                .padding(-8)

                Button {
                    viewModel.showCart = false
                } label: {
                    HStack {
                        Text("FAVORITEN")
                        Image(
                            systemName: viewModel.showCart
                                ? "bookmark" : "bookmark.fill")
                    }
                }
                .font(.footnote)
                .frame(maxWidth: .infinity, maxHeight: 4)
                .padding()
                //                .padding(.horizontal, 37)
                .border(.black)
                .background(viewModel.showCart ? Color.white : Color.black)
                .tint(viewModel.showCart ? .black : .white)
                .padding(-8)
            }
            .padding(.top)
            //FIXME: bei mehreren items geht die ganze leiste nach oben, schau es dir nochmal an!!

            //FIXME: Die ScrollView verhindert das man auf die Buttons klicken kann!!
            ScrollView {
                VStack {
                if viewModel.showCart {
//                    ForEach(viewModel.user.cart, id: \.cartID) { product in
                        ForEach(viewModelFirestore.cartList, id: \.cartID) { product in
//                    List(viewModel.testProducteArray) { product in
                                ZStack {
                                    Rectangle()
                                    //.fill(.clear)
                                        .frame(maxWidth: .infinity, maxHeight: 250)
                                        .foregroundStyle(.clear)
                                        .border(.black)
                                HStack {
                                    AsyncImage(url: URL(string: product.images[0]))
                                    {
                                        image in
                                        image
                                            .resizable()
                                            .frame(maxWidth: 200, maxHeight: 248)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    VStack {
                                        HStack(alignment: .lastTextBaseline) {
                                            Spacer()
                                            Button {
                                                //placeholder
                                            } label: {
                                                Image(systemName: "bookmark")
                                                    .resizable()
                                                    .frame(
                                                        maxWidth: 15, maxHeight: 22)
                                            }
                                            .padding(.horizontal)
                                            Button {
                                                //Placeholder
                                            } label: {
                                                Image(systemName: "xmark")
                                                    .resizable()
                                                    .frame(
                                                        maxWidth: 15, maxHeight: 20)
                                            }
                                        }
                                        //                                .padding(.top, 10)
                                        .padding(.horizontal)
                                        .frame(
                                            maxWidth: 200,
                                            alignment: .trailingLastTextBaseline
                                        )
                                        .tint(.black)
                                        
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text(product.title)
                                                .frame(maxWidth: 150, maxHeight: 50)
                                                .padding(.vertical, 5)
                                            Text("\(product.price.formatted()) EUR")
                                            Text(product.size ?? "keine Größe")
                                            
                                            HStack(spacing: 0) {
                                                Button("-") {
                                                    
                                                    if let index = viewModel.user
                                                        .cart
                                                        .firstIndex(where: {
                                                            $0.id == product.id
                                                        })
                                                    {
                                                        viewModel.user.cart[index]
                                                            .numberOfProducts? -= 1
                                                    }
                                                    Task {
                                                        try await viewModel
                                                            .getProductsFromAPI()
                                                    }
                                                }
                                                .tint(.primary)
                                                .padding()
                                                .border(.black)
                                                Text(
                                                    "\(product.numberOfProducts ?? 0)"
                                                )
                                                .padding()
                                                .border(.black)
                                                Button("+") {
                                                    if let index = viewModel.user
                                                        .cart
                                                        .firstIndex(where: {
                                                            $0.cartID
                                                            == product.cartID
                                                        })
                                                    {
                                                        viewModel.user.cart[index]
                                                            .numberOfProducts? += 1
                                                    }
                                                    Task {
                                                        try await viewModel
                                                            .getProductsFromAPI()
                                                    }
                                                }
                                                .tint(.primary)
                                                .padding()
                                                .border(.black)
                                            }
                                            .padding(.bottom)
                                        }
                                        .padding(.top)
                                        .frame(
                                            maxWidth: .infinity, alignment: .leading
                                        )
                                        
                                    }
                                    .padding(.top)
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        viewModel.user.cart.removeAll(where: {
                                            $0.cartID == product.cartID
                                        })
                                        Task {
                                            try await viewModel.getProductsFromAPI()
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    Button {
                                        if let addToFavorite = viewModel.user.cart
                                            .first(where: {
                                                $0.cartID == product.cartID
                                            })
                                        {
                                            viewModel.user.favorite.append(
                                                addToFavorite)
                                            viewModel.user.cart.removeAll(where: {
                                                $0.cartID == addToFavorite.cartID
                                            })
                                            Task {
                                                try await viewModel
                                                    .getProductsFromAPI()
                                            }
                                        }
                                    } label: {
                                        Label("Favorite", systemImage: "flag")
                                    }
                                    .tint(.yellow)
                                }
                            }
                        
                    }

//                                    .listStyle(.plain)
                    //                Spacer()
                    //                Spacer()
                } else {
//                    ForEach(viewModel.user.favorite, id: \.cartID) { product in
                    ForEach(viewModelFirestore.favoriteList, id: \.cartID) { product in
                        //                  ForEach(viewModel.testProducteArray) { product in
                        ZStack {
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 250)
                                .foregroundStyle(.white)
                                .border(.black)
                                .padding(.top, 4)  // muss mit Hstack angepasst werden, bei veränderung!

                            HStack {
                                AsyncImage(url: URL(string: product.images[0]))
                                {
                                    image in
                                    image
                                        .resizable()
                                        .frame(maxWidth: 200, maxHeight: 248)
                                } placeholder: {
                                    ProgressView()
                                }

                                VStack {
                                    HStack(alignment: .lastTextBaseline) {
                                        Spacer()
                                        Button {
                                            //placeholder
                                        } label: {
                                            Image(systemName: "cart")
                                                .resizable()
                                                .frame(
                                                    maxWidth: 18, maxHeight: 22)
                                        }
                                        .padding(.horizontal)
                                        Button {
                                            //Placeholder
                                        } label: {
                                            Image(systemName: "xmark")
                                                .resizable()
                                                .frame(
                                                    maxWidth: 15, maxHeight: 20)
                                        }
                                    }
                                    .padding(.top, 10)
                                    .padding(.horizontal)
                                    .frame(
                                        maxWidth: 200,
                                        alignment: .trailingLastTextBaseline
                                    )
                                    .tint(.black)

                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(product.title)
                                            .frame(maxWidth: 150, maxHeight: 50)
                                            .padding(.vertical, 5)
                                        Text("\(product.price.formatted()) EUR")
                                        Text(product.size ?? "keine Größe")

                                    }
                                    .padding(.top)
                                    .frame(
                                        maxWidth: .infinity, alignment: .leading
                                    )

                                }
                                //                            .padding(.top)
                            }
                            .padding(.top, 4)  // muss mit rectangle immer angepasst werden
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.user.favorite.removeAll(where: {
                                        $0.cartID == product.cartID
                                    })
                                    Task {
                                        try await viewModel.getProductsFromAPI()
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                Button {
                                    if let addToCart = viewModel.user.favorite
                                        .first(where: {
                                            $0.cartID == product.cartID
                                        })
                                    {
                                        viewModel.user.cart.append(
                                            addToCart)
                                        viewModel.user.favorite.removeAll(
                                            where: {
                                                $0.cartID == addToCart.cartID
                                            })
                                        Task {
                                            try await viewModel
                                                .getProductsFromAPI()
                                        }
                                    }
                                } label: {
                                    Label("Warenkorb", systemImage: "cart")
                                }
                                .tint(.yellow)
                            }
                        }
                    }
                    .onAppear {
                        Task {
                            try await viewModel.getProductsFromAPI()
                        }
                    }
                }
                                }
            }
            Spacer()
                
            if viewModel.showCart {
                VStack {
                    VStack {
                        HStack {
                            Text("Total:")
                            Spacer()
                            //                        Text("\(String(format: "%.2f", viewModel.user.cart.reduce(0) { $0 + $1.price }))€")
                            Text(
                                "\(String(format: "%.2f", viewModel.user.cart.reduce(0) { $0 + Double($1.numberOfProducts!) * $1.price })) EUR"
                            )
                        }
                        .font(.headline)
                        .padding()

                        HStack {
                            Spacer()
                            Text("INKL. MWST.")
                                .font(.footnote)
                        }
                        .padding(.horizontal)
                        .padding(.top, -18)
                        .padding(.bottom)
                    }
                    .border(Color.primary)
                    .padding(.bottom, -23)
                    NavigationLink("WEITER") {
                        OrderOverviewView(viewModel: viewModel)
                    }
                    .padding()
                    .frame(minWidth: 410)
                    .background(Color.black)
                    .tint(.white)
                    .padding()
                }
            } else {
                Spacer()
            }
        }
    }
}
#Preview {
    CartView(viewModel: ProductViewModel(), viewModelFirestore: FirestoreViewModel())
}
