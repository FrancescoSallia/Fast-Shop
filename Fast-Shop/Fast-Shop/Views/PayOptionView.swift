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
    var body: some View {
        NavigationStack {
        HStack {
            Text("zahlungsmethode auswählen")
                .textCase(.uppercase)
                .font(.subheadline)
            Spacer()
        }
        .padding()
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(payOptionItems, id: \.self) { option in
                    ZStack {
                        Rectangle()
                            .foregroundStyle(viewModel.selectedPayOption == option  ? .black : .white)
                            .aspectRatio(1.2, contentMode: .fill) // Stellt das Verhältnis von Breite zu Höhe sicher
                            .overlay(
                                Rectangle().stroke(viewModel.selectedPayOption == option ? Color.white : Color.black, lineWidth: 1.2)
                            )
                        Button {
                            viewModel.selectedPayOption = option
                            print(viewModel.selectedPayOption)
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
                        .tint(viewModel.selectedPayOption == option ? .white : .black)
                        
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
                    Text("\(String(format: "%.2f",viewModel.user.cart.reduce(0) { $0 + Double($1.numberOfProducts!) * $1.price } + viewModel.deliveryCost)) EUR")
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
