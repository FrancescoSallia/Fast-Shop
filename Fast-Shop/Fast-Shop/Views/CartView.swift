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
            Text("EINKAUFSKORB(2)")
                .font(.footnote)
                .frame(height: 4)
                .padding()
                .padding(.horizontal,35)
                .border(.black)
                .padding(.leading,-20)
            HStack {
                Text("FAVORITEN")
                Image(systemName: "bookmark")
            }
            .font(.footnote)
            .frame(height: 4)
            .padding()
            .padding(.horizontal,37)
            .border(.black)
            .padding(-10)
        }
        
//        ScrollView {
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
                            viewModel.user.cart.removeAll(where: {$0.id == product.id})
                        } label: {
                            Label("Favorite", systemImage: "flag")
                        }
                        .tint(.yellow)
                    }
            }
//                .padding()
            .listStyle(.plain)
//        }
        .onAppear {
            Task {
                try await viewModel.getProductsFromAPI()
            }
        }
    }
}
#Preview {
    CartView(viewModel: ProductViewModel())
}
