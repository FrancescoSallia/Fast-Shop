//
//  PayOptionView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 02.02.25.
//

import SwiftUI

struct PayOptionView: View {
    let payOptionItems: [String] = ["Google", "Apple", "Facebook", "ring"]
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
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
                                    .frame(width: 40, height: 40)
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
                    .frame(width: .infinity, height: 50)
                    .foregroundStyle(.white)
                    .border(Color.black)
                HStack {
                    Text("GESAMT")
                        .font(.footnote)
                    Spacer()
                    Text("129,98 EUR")
                        .textCase(.uppercase)
                        .font(.footnote)
                }
                .padding(.horizontal)
                .bold()
            }
            ZStack {
                Rectangle()
                    .frame(width: .infinity, height: 50)
                    .foregroundStyle(.black)
                NavigationLink("WEITER", destination: {
                    OrderOverviewView()
                })
                .tint(.white)
            }
            .padding(-8)
        }
    }
}
}

#Preview {
    PayOptionView()
}
