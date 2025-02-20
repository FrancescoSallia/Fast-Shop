//
//  CardView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 28.01.25.
//

import SwiftUI

struct CartView: View {
    
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var viewModelAdress: AdressViewModel
    @ObservedObject var viewModelFirestore: FirestoreViewModel
    @ObservedObject var errorHandler: ErrorHandler = .shared

    let columns = [GridItem(.fixed(400.0))]

    
var body: some View {
    NavigationStack {
        HStack {
           Button(
                "EINKAUFSKORB\(viewModelFirestore.cartList.count == 0 ? "" : "(\(viewModelFirestore.cartList.count))")"
            ) {
                viewModel.showCart = true
            }
            .font(.footnote)
            .frame(maxWidth: .infinity, maxHeight: 4)
            .padding()
            .border(.black)
            .background(viewModel.showCart ? Color.black : Color.white)
            .tint(viewModel.showCart ? .white : .black)

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
            .border(.black)
            .background(viewModel.showCart ? Color.white : Color.black)
            .tint(viewModel.showCart ? .black : .white)
            .padding(-8)
        }
            .padding(.top)
        
   ScrollView {
       VStack {
       if viewModel.showCart {
         ForEach(viewModelFirestore.cartList, id: \.cartID) { product in
                ZStack {
                  Rectangle()
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
                              viewModelFirestore.updateUserFavorite(product: product)
                              viewModelFirestore.deleteUserCart(product: product)
                              viewModel.showToastFavorite = true
                          } label: {
                              Image(systemName: "bookmark")
                                  .resizable()
                                  .frame(
                                      maxWidth: 15, maxHeight: 22)
                          }
                          .padding(.horizontal)
                          Button {
                              viewModelFirestore.deleteUserCart(product: product)
                              viewModel.showToastCartRemoved = true
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
                             Text(product.size == "" ? "" : "Size: \(product.size ?? "No Size")")
         
                             HStack(spacing: 0) {
                                 Button("-") {
         
                                     if let index = viewModelFirestore.cartList
                                         .firstIndex(where: {
                                             $0.id == product.id
                                         })
                                     {
                                         viewModelFirestore.cartList[index]
                                             .numberOfProducts? -= 1
                                     }
         
                                          viewModel.getProductsFromAPI()
         
                                 }
                                 .disabled(product.numberOfProducts == 1)
                                 .tint(.primary)
                                 .padding()
                                 .border(.black)
                                 Text(
                                     "\(product.numberOfProducts ?? 1)"
                                 )
                                 .padding()
                                 .border(.black)
                                 Button("+") {
                                     if let index = viewModelFirestore.cartList.firstIndex(where: {
                                             $0.cartID
                                             == product.cartID
                                         })
                                     {
                                         viewModelFirestore.cartList[index]
                                             .numberOfProducts? += 1
                                     }
                                     viewModel.getProductsFromAPI()
         
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
             }
        }
       } else {
           ForEach(viewModelFirestore.favoriteList, id: \.cartID) { product in
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
        
                        viewModel.selectedProduct = product
        
                        if viewModel.selectedProduct.category.id == 1 &&
                            !viewModel.selectedProduct.title.lowercased()
                            .contains("cap") {
        
                            viewModel.showClothesSizesOnCart = true
        
                        } else if viewModel.selectedProduct.category.id == 4 {
                            viewModel.showShoesSizesOnCart = true
        
                        } else {
                            if let index = viewModelFirestore.cartList.firstIndex(
                                where: {
                                $0.id == product.id
                            }
                            )
                             {
                                let updatedProduct = viewModelFirestore.cartList[index]
                                viewModelFirestore.deleteUserFavorite(
                                    product: updatedProduct
                                )
                                viewModel.showToastCart = true

                            } else {
                                viewModelFirestore.updateUserCart(product: product)
                                viewModelFirestore.deleteUserFavorite(product: product)
                                viewModel.showToastCart = true
                            }
                        }
                    } label: {
                        Image(systemName: "cart")
                            .resizable()
                            .frame(
                                maxWidth: 18, maxHeight: 22)
                            .padding(.top, 8)
                              }
                              .padding(.horizontal)
                              Button {
                                  viewModelFirestore.deleteUserFavorite(product: product)
                                  viewModel.showToastFavoriteRemoved = true
                              } label: {
                                  Image(systemName: "xmark")
                                      .resizable()
                                      .frame(
                                          maxWidth: 15, maxHeight: 20)
                              }
                          }
                          .padding(.horizontal)
                          .padding(.bottom, 30)
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
//                              Text("Size: \(product.size ?? "No Size")")
                          }
                          .padding(.bottom, 40)
                          .frame(
                              maxWidth: .infinity, alignment: .leading
                          )
                      }
                  }
                    .padding(.top, 4)  // muss mit rectangle immer angepasst werden
                            }
                        }
                        .onAppear {
                                viewModel.getProductsFromAPI()
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
                                Text(
                                    "\(String(format: "%.2f", viewModelFirestore.cartList.reduce(0) { $0 + Double($1.numberOfProducts!) * $1.price })) EUR"
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
                        NavigationLink("ZUR KASSE") {
                            OrderOverviewView(viewModel: viewModel, viewModelAdress: viewModelAdress, viewModelFirestore: viewModelFirestore)
                        }
                        .padding()
                        .frame(minWidth: 410)
                        .background(viewModelFirestore.cartList.isEmpty ? .clear : .black)
                        .tint(.white)
                        .padding()
                        .disabled(viewModelFirestore.cartList.isEmpty)
                    }
            } else {
                    Spacer()
                }
            }
            .sheet(isPresented: $viewModel.showClothesSizesOnCart) {
                ClothesSizeSheet(viewModel: viewModel, viewModelFirestore: viewModelFirestore, product: viewModel.selectedProduct)
                    .presentationDetents([.medium, .large])
            }
            .sheet(isPresented: $viewModel.showShoesSizesOnCart) {
                ShoesSizeSheet(viewModel: viewModel, viewModelFirestore: viewModelFirestore, product: viewModel.selectedProduct)
                    .presentationDetents([.medium, .large])
            }
            .alert(isPresented: $errorHandler.showError) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorHandler.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
        }
    }
}
#Preview {
    CartView(viewModel: ProductViewModel(), viewModelAdress: AdressViewModel(), viewModelFirestore: FirestoreViewModel())
}
