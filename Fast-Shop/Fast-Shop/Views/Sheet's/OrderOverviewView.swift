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
        VStack {
            ScrollView {
//                Text("Donnerstag 06, Februar - Freitag 08, Februar")
                Text(viewModel.selectedDateFormatted)
                    .textCase(.uppercase)
                    .font(.subheadline)
                
                HStack {
//                    Text("4 Artikel")
                    Text("\(viewModel.user.cart.count) Artikel")
                        .font(.footnote)
                        .textCase(.uppercase)
                    Spacer()
                }
                .padding(.horizontal)
                
                
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
                HStack {
                    Text("Versand nach Hause")
                        .textCase(.uppercase)
                        .font(.footnote)
                    Spacer()
                }
                .padding()
                HStack {
                    Text("Zustellung Donnerstag 06, Februar - Freitag 08, Februar")
                        .textCase(.uppercase)
                        .font(.footnote)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, -16)
                Divider()
                    .frame(height: 2)
                    .background(Color.black)
                VStack(alignment: .leading) {
                    Text(viewModel.user.name)
                        .textCase(.uppercase)
                    Text("\(viewModel.user.adress) \(viewModel.user.houseNumber)")
                        .textCase(.uppercase)
                    Text("\(viewModel.user.plz) \(viewModel.user.location)")
                        .textCase(.uppercase)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                    .frame(height: 2)
                    .background(Color.black)
                
                HStack {
                    Image(viewModel.selectedPayOption)
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text(viewModel.selectedPayOption)
                        .textCase(.uppercase)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                Divider()
                    .frame(height: 2)
                    .background(Color.black)
                HStack{
                    Text("\(viewModel.user.cart.count) Artikel")
                        .textCase(.uppercase)
                    Spacer()
                    Text("128,95 EUR")
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
                
                Divider()
                    .frame(height: 2)
                    .background(Color.black)

            }
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
}
#Preview {
    OrderOverviewView(viewModel: ProductViewModel())
}
