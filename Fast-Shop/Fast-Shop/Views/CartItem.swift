//
//  CartItem.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 29.01.25.
//

import SwiftUI

struct CartItem: View {
    @ObservedObject var viewModel = ProductViewModel()
//    let columns = [GridItem(.fixed(300.0)) /*[GridItem(.flexible())*/]
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
        ), size: "",
        numberOfProducts: 0),
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
                                      ),
                                      size: "",
                                      numberOfProducts: 0
                                  )
                                ]

    var body: some View {
//        ScrollView {
                List(testProducts) { product in
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
                                Label("Delete", systemImage: "flag")
                            }
                            .tint(.yellow)
                        }
                }
//                .padding()
                .listStyle(.plain)
            
//        }
    }
}

#Preview {
    CartItem()
}
