//
//  CardView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 28.01.25.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: ProductViewModel
    @State var sizes: [String] = ["XS","S", "M", "L", "XL", "XXL"]
    @State var counter = 0
//    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let columns = [GridItem(.fixed(400.0))]

    
    var body: some View {
        NavigationStack {
            HStack {
                Button("EINKAUFSKORB\(viewModel.user.cart.count == 0 ? "" : "(\(viewModel.user.cart.count))")") {
                    viewModel.showCart = true
                }
                .font(.footnote)
                .frame(height: 4)
                .padding()
                .padding(.horizontal,35)
                .border(.black)
                .background(viewModel.showCart ? Color.black : Color.white)
                .tint(viewModel.showCart ? .white : .black)
                .padding(.leading,-20)
                Button {
                    viewModel.showCart = false
                }label: {
                    HStack {
                        Text("FAVORITEN")
                        Image(systemName: viewModel.showCart ? "bookmark" : "bookmark.fill")
                    }
                }
                .font(.footnote)
                .frame(height: 4)
                .padding()
                .padding(.horizontal,37)
                .border(.black)
                .background(viewModel.showCart ? Color.white : Color.black)
                .tint(viewModel.showCart ? .black : .white)
                .padding(-10)
            }
            .padding(.top)
            
            if viewModel.showCart {
//                List(viewModel.user.cart, id: \.cartID) { product in
                ForEach(viewModel.testProducteArray) { product in
                        ZStack {
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 250)
                                .foregroundStyle(.white)
                                .border(.black)
                        HStack {
                            AsyncImage(url: URL(string: product.images[0])) { image in
                                image
                                    .resizable()
                                    .frame(maxWidth: 200,maxHeight: 248)
                            } placeholder: {
                                if !product.images.isEmpty {
                                    Image("pants")
                                        .resizable()
                                        .frame(maxWidth: 190, maxHeight: 240)
                                } else {
                                    ProgressView()
                                }
                            }
                            VStack {
                                HStack(alignment: .lastTextBaseline) {
                                    Spacer()
                                    Button {
                                        //placeholder
                                    } label: {
                                        Image(systemName: "bookmark")
                                    }
                                    Button{
                                        //Placeholder
                                    } label:{
                                        Image(systemName: "xmark")
                                    }
                                }
                                .frame(maxWidth: 200, alignment: .trailingLastTextBaseline)
                                .tint(.black)
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    Text(product.title)
                                    Text("\(product.price.formatted()) EUR")
                                    Text(product.size ?? "keine Größe")
                                    
                                    HStack(spacing: 0) {
                                        Button("-") {
                                            counter -= 1
                                            
                                            //                                                                        if let index = viewModel.user.cart.firstIndex(where: {$0.id == product.id}) {
                                            //                                                                            viewModel.user.cart[index].numberOfProducts? -= 1
                                            //                                                                        }
                                            //                                    Task {
                                            //                                        try await viewModel.getProductsFromAPI()
                                            //                                    }
                                        }
                                        .padding()
                                        .border(.black)
                                        .frame(maxHeight: .infinity)
                                        //                                Text("\(product.numberOfProducts ?? 0)")
                                        Text("\(counter)")
                                            .padding()
                                            .border(.black)
                                            .frame(maxHeight: .infinity)
                                        Button("+") {
                                            counter += 1
                                            //                                    if let index = viewModel.user.cart.firstIndex(where: {$0.cartID == product.cartID}) {
                                            //                                        viewModel.user.cart[index].numberOfProducts? += 1
                                            //                                    }
                                            //                                    Task {
                                            //                                        try await viewModel.getProductsFromAPI()
                                            //                                    }
                                        }
                                        .padding()
                                        .border(.black)
                                        .frame(maxHeight: .infinity)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)

                                
                            }
                            .padding(.top)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.user.cart.removeAll(where: {$0.cartID == product.cartID})
                                Task {
                                    try await viewModel.getProductsFromAPI()
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            Button {
                                if let addToFavorite = viewModel.user.cart.first(where: {$0.cartID == product.cartID}) {
                                    viewModel.user.favorite.append(addToFavorite)
                                    viewModel.user.cart.removeAll(where: {$0.cartID == addToFavorite.cartID})
                                    Task {
                                        try await viewModel.getProductsFromAPI()
                                    }
                                }
                            } label: {
                                Label("Favorite", systemImage: "flag")
                            }
                            .tint(.yellow)
                        }
                    }
                }
//                .listStyle(.plain)
                
                
                
                
                
                
            } else {
                List(viewModel.user.favorite, id: \.cartID) { product in
                    HStack (alignment: .top) {
                        AsyncImage(url: URL(string: product.images[0])) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 190)
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
                                }
                                Button{
                                    //Placeholder
                                } label:{
                                    Image(systemName: "xmark")
                                }
                            }
                            .tint(.black)
                            Text(product.title)
                                .font(.footnote)
                                .padding(.top, 40)
                                .padding(.leading, 20)
                                .frame(width: 160)
                            
                            //                                    .padding(.trailing, 70)
                            
                            Text("\(product.price.formatted()) EUR")
                                .font(.footnote)
                                .fontWeight(.thin)
                                .padding(.top, 20)
                                .padding(.trailing, 65)
                                .padding(.bottom)
                            
                            HStack {
                                ZStack {
                                    Rectangle()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.white)
                                        .border(.black)
                                    Button("-") {
                                        if let index = viewModel.user.cart.firstIndex(where: {$0.cartID == product.cartID}) {
                                            viewModel.user.cart[index].numberOfProducts? -= 1
                                        }
                                    }
                                    .tint(.primary)
                                }
                                Text("\(product.numberOfProducts ?? 0)")
                                    .fontDesign(.serif)
                                    .fontWeight(.thin)
                                    .foregroundStyle(.black)
                                    .frame(width: 30, height: 30)
                                    .border(.black, width: 1)
                                
                                
                                
                                ZStack {
                                    Rectangle()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.white)
                                        .border(.black)
                                    Button("+") {
                                        if let index = viewModel.user.cart.firstIndex(where: {$0.cartID == product.cartID}) {
                                            viewModel.user.cart[index].numberOfProducts? += 1
                                        }
                                    }
                                    .tint(.primary)
                                }
                            }
                        }
                        .padding(.top)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.user.favorite.removeAll(where: {$0.cartID == product.cartID})
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        Button {
                            if let addToCart = viewModel.user.favorite.first(where: {$0.cartID == product.cartID}) {
                                viewModel.user.cart.append(addToCart)
                                viewModel.user.favorite.removeAll(where: {$0.cartID == addToCart.cartID})
                                Task {
                                    try await viewModel.getProductsFromAPI()
                                }
                            }
                        } label: {
                            Label("Add to Cart", systemImage: "bag")
                        }
                        .tint(.yellow)
                    }
                }
                .listStyle(.plain)
                .onAppear {
                    Task {
                        try await viewModel.getProductsFromAPI()
                    }
                }
            }
            if viewModel.showCart {
                VStack {
                    VStack {
                        HStack {
                            Text("Total:")
                            Spacer()
                            //                        Text("\(String(format: "%.2f", viewModel.user.cart.reduce(0) { $0 + $1.price }))€")
                            Text("\(String(format: "%.2f", viewModel.user.cart.reduce(0) { $0 + Double($1.numberOfProducts!) * $1.price })) EUR")
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
            }
        }
    }
}
#Preview {
    CartView(viewModel: ProductViewModel())
}
