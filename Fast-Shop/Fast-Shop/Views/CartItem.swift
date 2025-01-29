//
//  CartItem.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 29.01.25.
//

import SwiftUI

struct CartItem: View {
    @ObservedObject var viewModel = ProductViewModel()
    let columns = /*[GridItem(.fixed(400.0))]*/ [GridItem(.flexible())]
    var testProducts: [Product] = [Product(
        id: 1,
        title: "Classic Navy Blue Baseball Cap",
        price: 20.0,
        description: "Test Description",
        images: [
        "https://i.imgur.com/R3iobJA.jpeg",
        "https://i.imgur.com/Wv2KTsf.jpeg",
        "https://i.imgur.com/76HAxcA.jpeg"
      ],
        category: Category(
            id: 1,
            name: "Tools",
            image: "tools.png",
            creationAt: "2025-01-24T08:29:50.000Z",
            updatedAt: "2025-01-24T09:42:00.000Z"
        )),
                                  Product(
                                      id: 2,
                                      title: "Classic Navy Blue Baseball Cap",
                                      price: 20.0,
                                      description: "Test Description",
                                      images: [
                                      "https://i.imgur.com/R3iobJA.jpeg",
                                      "https://i.imgur.com/Wv2KTsf.jpeg",
                                      "https://i.imgur.com/76HAxcA.jpeg"
                                    ],
                                      category: Category(
                                          id: 1,
                                          name: "Tools",
                                          image: "tools.png",
                                          creationAt: "2025-01-24T08:29:50.000Z",
                                          updatedAt: "2025-01-24T09:42:00.000Z"
                                      ))
                                  ]

    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(testProducts) { product in
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
                                        //Placeholder
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
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.user.cart.removeAll(where: {$0.id == product.id})
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }

            }
        }
    }
}

#Preview {
    CartItem()
}
