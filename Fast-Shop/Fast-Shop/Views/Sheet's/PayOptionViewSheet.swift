//
//  PayOptionView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 02.02.25.
//

import SwiftUI

struct PayOptionViewSheet: View {
    
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var errorHandler: ErrorHandler = .shared
    
    let payOptionItems: [String] = ["apple-pay", "klarna", "google-pay", "paypal"]
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)

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
                            .foregroundStyle(viewModel.selectedPayOption == option  ? .gray.opacity(0.2) : .white)
                            .aspectRatio(1.2, contentMode: .fill) // Stellt das Verhältnis von Breite zu Höhe sicher
                            .overlay(
                                Rectangle().stroke(Color.black, lineWidth: 1.2)
                            )
                        Button {
                            viewModel.selectedPayOption = option
                            viewModel.showPayOptionViewSheet = false
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
                        .tint(.primary)
                        
                    }
                }
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
    PayOptionViewSheet(viewModel: ProductViewModel())
}
