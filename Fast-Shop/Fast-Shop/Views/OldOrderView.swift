//
//  OldOrderView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 14.02.25.
//

import SwiftUI

struct OldOrderView: View {
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var viewModelFirestore: FirestoreViewModel
    @ObservedObject var errorHandler: ErrorHandler = .shared

//    @State var pickerOldOrder: String = "All"
    
    var groupedOrders: [(key: String, value: [Product])] {
        let grouped = Dictionary(grouping: viewModelFirestore.oldOrderList) { $0.date ?? "No Date" }
        return grouped.sorted { $0.key > $1.key }
    }
    
    var body: some View {
        List {
            ForEach(groupedOrders, id: \.key) { (date, products) in
                Section(header: Text(date)) {
                    ForEach(products, id: \.cartID) { item in
                        HStack {
                            AsyncImage(url: URL(string:item.images[0])) { pic in
                                pic
                                    .resizable()
                                    .scaledToFit()
                                    .frame(
                                        maxWidth: 200,
                                        maxHeight: 250)
                            } placeholder: {
                                ProgressView()
                            }
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.size == "" ? "" : "Size: \(item.size!)")
                                    .font(.subheadline)
                                    .padding(.vertical)
                                Text("Preis: \(String(format: "%.2f", item.price)) EUR")
                                    .font(.subheadline)
                            }
                        }

                    }
                    HStack {
                        Text("Gesamt: ")
                        Spacer()
                        Text("\(String(format: "%.2f", products.reduce(0) { $0 + (Double($1.numberOfProducts ?? 0) * $1.price) } + viewModel.deliveryCost)) EUR")
                        Image(systemName: "creditcard.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 30)
                            .tint(.black)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle("Old-Orders")
        
//        .toolbar {
//            Picker(selection: $pickerOldOrder) {
//                <#code#>
//            } label: {
//                Image(systemName: "line.3.horizontal.decrease")
//                    .tint(.black)
//            }
//
//        }
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
    OldOrderView(viewModel: ProductViewModel(), viewModelFirestore: FirestoreViewModel())
}
