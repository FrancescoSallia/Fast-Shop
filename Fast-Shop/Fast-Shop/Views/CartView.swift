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
    @State var counter = 1
//    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let columns = [GridItem(.fixed(400.0))]

    
    var body: some View {
        
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
                    Image(systemName: "bookmark")
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
            List(viewModel.user.cart) { product in
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
                            Button {
                                //placeholder
                            } label: {
                                Text("-")
                                    .fontWeight(.thin)
                                    .foregroundStyle(.black)
                                    .frame(width: 30, height: 30)
                                    .border(.black, width: 1)
                            }
                            Text("10")
                                .fontDesign(.serif)
                                .fontWeight(.thin)
                                .foregroundStyle(.black)
                                .frame(width: 30, height: 30)
                                .border(.black, width: 1)
                            Button {
                                //placeholder
                            } label: {
                                Text("+")
                                    .fontWeight(.thin)
                                    .foregroundStyle(.black)
                                    .frame(width: 30, height: 30)
                                    .border(.black, width: 1)
                            }
                        }
                    }
                    .padding(.top)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        viewModel.user.cart.removeAll(where: {$0.id == product.id})
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    Button {
                        if let addToFavorite = viewModel.user.cart.first(where: {$0.id == product.id}) {
                            viewModel.user.favorite.append(addToFavorite)
                            viewModel.user.cart.removeAll(where: {$0.id == addToFavorite.id})
                        }
                    } label: {
                        Label("Favorite", systemImage: "flag")
                    }
                    .tint(.yellow)
                }
            }
            .listStyle(.plain)
        } else {
            List(viewModel.user.favorite) { product in
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
                            Button {
                                //placeholder
                            } label: {
                                Text("-")
                                    .fontWeight(.thin)
                                    .foregroundStyle(.black)
                                    .frame(width: 30, height: 30)
                                    .border(.black, width: 1)
                            }
                            Text("10")
                                .fontDesign(.serif)
                                .fontWeight(.thin)
                                .foregroundStyle(.black)
                                .frame(width: 30, height: 30)
                                .border(.black, width: 1)
                            Button {
                                //placeholder
                            } label: {
                                Text("+")
                                    .fontWeight(.thin)
                                    .foregroundStyle(.black)
                                    .frame(width: 30, height: 30)
                                    .border(.black, width: 1)
                            }
                        }
                    }
                    .padding(.top)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        viewModel.user.favorite.removeAll(where: {$0.id == product.id})
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    Button {
                        if let addToCart = viewModel.user.favorite.first(where: {$0.id == product.id}) {
                            viewModel.user.cart.append(addToCart)
                            viewModel.user.favorite.removeAll(where: {$0.id == addToCart.id})
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
        VStack {
            HStack {
                Text("Total:")
                Spacer()
              Text("29,95€")
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
        Button("WEITER") {
            //
        }
        .padding()
        .frame(minWidth: 410)
//        .border(Color.black)
        .background(Color.black)
        .tint(.white)
        .padding()

    }
}
#Preview {
    CartView(viewModel: ProductViewModel())
}
