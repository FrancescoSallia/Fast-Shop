//
//  CardView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 28.01.25.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: ProductViewModel
//    let productsFromCard: [Product]
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
        
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.user.cart ?? []) { product in
                    HStack (alignment: .top) {
                        AsyncImage(url: URL(string: product.images[0])) { image in
                            image
                                .resizable()
                            //                                        .scaledToFit()
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
                                    viewModel.user.cart.removeAll(where: {$0.id == product.id})
                                } label:{
                                    Image(systemName: "xmark")
                                }
                            }
                            .tint(.black)
                            .padding()
                            Text(product.title)
                                .font(.footnote)
                                .padding(.top, 50)
                                .padding(.trailing, 70)
                            
                            Text("\(product.price.formatted()) EUR")
                                .font(.footnote)
                                .fontWeight(.thin)
                                .padding(.top, 20)
                                .padding(.trailing, 130)
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
                            .padding(.trailing, 80)
                            .padding(.top, 66)
                            
                            
                        }
                    }
                    .frame(minWidth: 418, maxHeight: 300)
                    .ignoresSafeArea()
                    .border(.black)
                    
//                    .swipeActions(edge: .trailing) {
//                        Button(role: .destructive) {
//                            viewModel.user.cart.removeAll(where: {$0.id == product.id})
//                        } label: {
//                            Label("Delete", systemImage: "trash")
//                        }
//                    }

                }
            }
                
            
                
                
                //            ForEach(viewModel.user.cart) { product in
                //            ZStack {
                //                HStack {
                //
                //                    AsyncImage(url: URL(string: product.images[0])) { image in
                //                        image
                //                            .resizable()
                //                            .frame(maxWidth: .infinity, maxHeight: 300)
                //                            .padding(.trailing, -8)
                //                    } placeholder: {
                //                        ProgressView()
                //                    }
                //
                //
                ////                        Image("pants")
                ////                            .resizable()
                ////                            .frame(maxWidth: .infinity, maxHeight: 300)
                ////                            .padding(.trailing, -8)
                //                    Rectangle()
                //                        .foregroundStyle(.white)
                //                        .frame(maxWidth: .infinity, maxHeight: 300)
                //                }
                //
                //                VStack {
                //                    HStack {
                //                        Button {
                //
                //                        } label: {
                //                            Image(systemName: "bookmark")
                //                        }
                //                        .tint(.black)
                //                        Button {
                //
                //                        } label: {
                //                            Image(systemName: "xmark")
                //                        }
                //                        .tint(.black)
                //                    }
                //                    .padding()
                //                    .offset(x:160, y: -90)
                //
                //                    Group {
                //                        Text(product.title)
                //                        Text("Preis vom Produkt")
                //                    }
                //                    .font(.footnote)
                //                    .offset(x: 70, y: -70)
                //                }
                //                HStack(spacing: 30) {
                //                    Button("-"){
                //                        $counter.wrappedValue -= 1
                //                    }
                //                    .disabled(counter == 0 ? true : false)
                //
                //                    Text("\(counter)")
                //                    Button("+"){
                //                        $counter.wrappedValue += 1
                //                    }
                //                }
                //                .tint(.black)
                //                .padding()
                //                .border(.black)
                //                .font(.headline)
                //                .offset(x: 80, y: 115)
                //
                //
                //            }
                //            .border(.black)
                //        }
                
                }
    }
}

#Preview {
    CartView(viewModel: ProductViewModel())
}
