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
                                HStack() {
                                    Button("HINZUFÜGEN") {
                                        //
                                    }
                                    .frame(width: 280, height: 45)
                                    .border(Color.gray)
                                    .tint(.white)
                                    .background(Color.primary)
                                    
                                    Button {
                                        //
                                    } label: {
                                        Image(systemName: "bookmark")
                                    }
                                    .frame(width: 55, height: 45)
                                    .border(Color.gray)
                                    .tint(.white)
                                    .background(Color.primary)
                                    .padding(.leading, 12)
                                }
                                .padding(.top, 40)
                                
                                Text(product.description)
                                    .padding()
                            }
                            .padding(.horizontal)
                        }
                    
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            //
                        } label:{
                            Image(systemName: "square.and.arrow.up")
                        }
                        .foregroundStyle(.primary)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        ZStack {
                            Button {
                                //
                            } label:{
                                Image(systemName: "bag")
                            }
                            .foregroundStyle(.primary)

                            Text("2")
                                .font(.footnote)
                                .offset(x: 3, y: 1)
                                .foregroundStyle(.primary)
                        }
                    }
                })
            }
        }
    }
}
#Preview {
    ProductDetailView(product: ProductViewModel().testProduct, viewModel: ProductViewModel())
}
