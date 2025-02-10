//
//  OrderOverview.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 03.02.25.
//

import SwiftUI

struct OrderOverviewView: View {
    let dummyArtikeln: [String] = ["tasche", "pants", "tshirt", "ring"]
    @ObservedObject var viewModel: ProductViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Text("\(viewModel.user.cart.count) Artikel")
                    .font(.footnote)
                    .textCase(.uppercase)
                ScrollView {
                    //                Text("Donnerstag 06, Februar - Freitag 08, Februar")
                    
//                    HStack {
//                        Text("\(viewModel.user.cart.count) Artikel")
//                            .font(.footnote)
//                            .textCase(.uppercase)
//                        Spacer()
//                    }
//                    .padding(.horizontal)
                    
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.user.cart, id: \.cartID) { item in
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
//                        OrderView(viewModel: viewModel)
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
                        AdressView(viewModel: viewModel)
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
                            Text(viewModel.user.adress?.firstName ?? "NO NAME")
                                .textCase(.uppercase)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                        Text("\(viewModel.user.adress?.street ?? "NO STREET") \(viewModel.user.adress?.houseNumber ?? "NO HOUSENUMBER")")
                            .textCase(.uppercase)
                        Text("\(viewModel.user.adress?.plz ?? "NO PLZ") \(viewModel.user.adress?.location ?? "NO LOCATION")")
                            .textCase(.uppercase)
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
                    Text("\(viewModel.user.cart.count) Artikel")
                        .textCase(.uppercase)
                    Spacer()
                    Text("\(String(format: "%.2f", viewModel.user.cart.reduce(0) { $0 + Double($1.numberOfProducts!) * $1.price })) EUR")
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
                    Text("\(String(format: "%.2f",viewModel.user.cart.reduce(0) { $0 + Double($1.numberOfProducts!) * $1.price } + viewModel.deliveryCost)) EUR")
                    //Text("128,95 EUR")
                        .bold()
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                //            Divider()
                //                .frame(height: 2)
                //                .background(Color.black)
            }
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundStyle(.black)
                Button("Zahlung Autorisieren") {
                    //
                }
                .tint(.white)
                .textCase(.uppercase)
            }
            //        .padding(-8)
        }
        .sheet(isPresented: $viewModel.showOrderViewSheet) {
            DeliveryDateViewSheet(viewModel: viewModel)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $viewModel.showPayOptionViewSheet) {
            PayOptionViewSheet(viewModel: viewModel)
                .presentationDetents([.medium])
        }
    }
}
#Preview {
    OrderOverviewView(viewModel: ProductViewModel())
}
