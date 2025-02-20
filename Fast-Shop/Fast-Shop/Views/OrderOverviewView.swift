//
//  OrderOverview.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 03.02.25.
//

import SwiftUI

struct OrderOverviewView: View {
    @Environment(\.dismiss) var dismiss

    let dummyArtikeln: [String] = ["tasche", "pants", "tshirt", "ring"]
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var viewModelAdress: AdressViewModel
    @ObservedObject var viewModelFirestore: FirestoreViewModel
    @ObservedObject var errorHandler: ErrorHandler = .shared

    @State private var navigateToCart = false

    var body: some View {
        NavigationStack {
            VStack {
          Text("\(viewModelFirestore.cartList.count) Artikel")
              .font(.footnote)
              .textCase(.uppercase)
          ScrollView {
              ScrollView(.horizontal) {
                  HStack {
                      ForEach(viewModelFirestore.cartList, id: \.cartID) { item in
                          AsyncImage(url: URL(string: item.images[0])) { item in
                              item
                                  .resizable()
                                  .frame(width: 122, height: 180)
                          } placeholder: {
                              ProgressView()
                          }
                      }
                  }
              }
//DELIVERY CALENDAR SECTION
         Button {
             viewModel.showOrderViewSheet = true
             
         } label: {
             VStack(alignment: .leading) {
                 HStack {
                     Image(systemName: "calendar")
                     Text("Erwartete Zustellung")
                         .font(.subheadline)
                         .bold()
                     Spacer()
                     Image(systemName: "chevron.right")
                         .foregroundColor(.black)
                 }
                 .padding(.bottom, 4)
                 Text(viewModel.selectedDeliveryOption == 0 ? "\(viewModel.deliveryDate(daysToAdd: 4)) - \(viewModel.deliveryDate(daysToAdd: 6))" : "\(viewModel.deliveryDate(daysToAdd: 1)) - \(viewModel.deliveryDate(daysToAdd: 3))")
                     .font(.footnote)
                     .textCase(.uppercase)
                     .font(.subheadline)
             }
             .padding()
         }
         .tint(.primary)
         Divider()
             .frame(height: 2)
             .background(Color.black)
                    
//ADRESS SECTION
        NavigationLink {
            AdressView(viewModel: viewModelAdress, viewModelFirestore: viewModelFirestore)
        } label: {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "house")
                Text("Lieferadresse")
                    .bold()
                    .font(.subheadline)
                Spacer()
            }
            .padding(.bottom)
            HStack {
                if viewModelAdress.selectedAdressOption == "" {
                    HStack {
                        Text("Wähle eine Lieferadresse aus um fortzufahren!")
                            .foregroundStyle(.red)
                            .textCase(.uppercase)
                            .font(.footnote)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                }
                if let index = viewModelFirestore.adressList.firstIndex(where: { $0.adressID == viewModelAdress.selectedAdressOption }) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(viewModelFirestore.adressList[index].firstName) \(viewModelFirestore.adressList[index].secondName)")
                                .textCase(.uppercase)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                        Text("\(viewModelFirestore.adressList[index].street)")
                            .textCase(.uppercase)
                        Text("\(viewModelFirestore.adressList[index].plz) \(viewModelFirestore.adressList[index].location)")
                            .textCase(.uppercase)
                    }
                    .padding(.horizontal)
            }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        }
        .tint(.primary)
        Divider()
            .frame(height: 2)
            .background(Color.black)
                    
//PAYMENT SECTION
        Button {
            viewModel.showPayOptionViewSheet = true
        } label: {
            VStack {
                HStack {
                    Image(systemName: "creditcard")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .tint(.primary)
                    Text("Bezahlart")
                        .tint(.primary)
                        .font(.subheadline)
                        .bold()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 4)
                .padding(.horizontal)
                HStack {
                    Text(viewModel.selectedPayOption)
                        .textCase(.uppercase)
                        .font(.subheadline)
                        .tint(.black)
                    Spacer()
                    Image(viewModel.selectedPayOption)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, -16)
            }
        }
        
        Divider()
            .frame(height: 2)
            .background(Color.black)
    }
    
//Summary Section
                Divider()
                    .frame(height: 2)
                    .background(Color.black)
                HStack{
                    Text("\(viewModelFirestore.cartList.count) Artikel")
                        .textCase(.uppercase)
                    Spacer()
                    
                   Text("\(String(format: "%.2f", viewModelFirestore.cartList.reduce(0) { $0 + Double($1.numberOfProducts!) * $1.price })) EUR")
                }
                .padding(.top)
                .padding(.horizontal)
                HStack{
                    Text("Versand")
                        .textCase(.uppercase)
                    Spacer()
                    Text("\(viewModel.selectedDeliveryPrice) EUR")
                    //                    Text("0,00 EUR")
                }
                .padding(.horizontal)
                HStack{
                    Text("Gesamt")
                        .textCase(.uppercase)
                        .bold()
                    Spacer()
                    Text("\(String(format: "%.2f",viewModelFirestore.cartList.reduce(0) { $0 + Double($1.numberOfProducts!) * $1.price } + viewModel.deliveryCost)) EUR")
                        .bold()
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Bestell-Übersicht")
            .toolbar(.hidden, for: .navigationBar)
            
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundStyle(viewModelAdress.selectedAdressOption == "" ? .clear : .black)
            Button("Zahlung Autorisieren") {
                viewModel.showLottieSuccessfullView.toggle()
                
                for product in viewModelFirestore.cartList {
                    let oldProduct = Product(
                        fireID: product.fireID,
                        id: product.id,
                        title: product.title,
                        price: product.price,
                        description: product.description,
                        images: product.images,
                        category: product.category,
                        isFavorite: product.isFavorite,
                        size: product.size,
                        numberOfProducts: product.numberOfProducts,
                        cartID: product.cartID,
                        oldOrderID: UUID().uuidString,
                        date: Date().formatted(.iso8601.year().month().day())
                    )
                    viewModelFirestore.updateUserOldOrder(product: oldProduct)
                    viewModelFirestore.deleteUserCart(product: product)
                }
            }
            .tint(.white)
            .textCase(.uppercase)
            .disabled(viewModelAdress.selectedAdressOption == "" ? true : false)
        }
    }
        .sheet(isPresented: $viewModel.showOrderViewSheet) {
            DeliveryDateViewSheet(viewModel: viewModel)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $viewModel.showPayOptionViewSheet) {
            PayOptionViewSheet(viewModel: viewModel)
                .presentationDetents([.medium])
        }
        .fullScreenCover(isPresented: $viewModel.showLottieSuccessfullView) {
            LottiesView()
                .onAppear {
                    Task {
                        try await Task.sleep(for: .seconds(4))
                          viewModel.showLottieSuccessfullView = false
                        dismiss()
                        dismiss()
                    }
                }
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
    OrderOverviewView(viewModel: ProductViewModel(), viewModelAdress: AdressViewModel(), viewModelFirestore: FirestoreViewModel())
}
