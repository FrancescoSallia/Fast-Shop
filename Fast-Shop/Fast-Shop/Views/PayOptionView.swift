//
//  PayOptionView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 02.02.25.
//

import SwiftUI

struct PayOptionView: View {
    let payOptionItems: [String] = ["apple-pay", "klarna", "google-pay", "paypal"]
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
    @ObservedObject var viewModel: ProductViewModel
    @State var selectedPayOption: String = ""
    var body: some View {
        NavigationStack {
        HStack {
            Text("zahlungsmethode auswählen")
                .textCase(.uppercase)
                .font(.subheadline)
            Spacer()
            //            Button {
            //                // sheet schließen
            //            } label: {
            //                Image(systemName: "xmark.circle.fill")
            //                    .resizable()
            //                    .frame(width: 24, height: 24)
            //                    .tint(.black)
            //            }
        }
        .padding()
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(payOptionItems, id: \.self) { option in
                    ZStack {
                        Rectangle()
                            .foregroundStyle(selectedPayOption == option  ? .black : .white)
                            .aspectRatio(1.2, contentMode: .fill) // Stellt das Verhältnis von Breite zu Höhe sicher
                            .overlay(
                                Rectangle().stroke(selectedPayOption == option ? Color.white : Color.black, lineWidth: 1.2)
                            )
                        Button {
                            selectedPayOption = option
                        } label: {
                            VStack {
                                Image(option)
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                Text(option)
                                    .font(.caption)
                                    .textCase(.uppercase)
                                    .italic()
                            }
                        }
                        .tint(selectedPayOption == option ? .white : .black)
                        
                    }
                }
            }
        }
        VStack {
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundStyle(.white)
                    .border(Color.black)
                HStack {
                    Text("GESAMT")
                        .font(.footnote)
                    Spacer()
//                    Text("129,98 EUR")
                    Text("\(String(format: "%.2f",viewModel.user.cart.reduce(0) { $0 + Double($1.numberOfProducts!) * $1.price } + viewModel.deliveryCost))€")
                        .textCase(.uppercase)
                        .font(.footnote)
                }
                .padding(.horizontal)
                .bold()
            }
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundStyle(.black)
                NavigationLink("WEITER", destination: {
                    OrderOverviewView(viewModel: viewModel)
                })
                .tint(.white)
            }
            .padding(-8)
        }
    }
}
}

#Preview {
    PayOptionView(viewModel: ProductViewModel())
}
