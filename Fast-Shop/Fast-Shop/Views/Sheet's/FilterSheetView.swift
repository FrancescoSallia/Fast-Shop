//
//  FilterSheetView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 27.01.25.
//

import SwiftUI

struct FilterSheetView: View {
    @State private var price = 50.0
    @State private var isEditing = false
    @State var showFilterSheetView: Bool = false
    @State var productList: [Product] = []
    
    var body: some View {
        Text("min und max Preis EUR")
        Slider(
                value: $price,
                in: 0...150,
                step: 5
            ) {
                Text("Speed")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("150")
            } onEditingChanged: { editing in
                Task {
                    try await minMaxPriceFiltered()
                }
                isEditing = editing
            }
        Text("\(price.formatted())")
            .foregroundColor(isEditing ? .green : .blue)
        
        
        
        
        
        List(productList) { list in
            Text(list.title)
            Text(list.price.formatted())
        }
            .onAppear {
                Task {
                    try await minMaxPriceFiltered()
                }
            }
    }
    
     func minMaxPriceFiltered() async throws {
         guard let url = URL(string: "https://api.escuelajs.co/api/v1/products/?price_min=\(String(price))&price_max=100&categoryId=1") else {throw errorEnum.invalidURL}
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            productList = try JSONDecoder().decode([Product].self, from: data)
        } catch {
            print(error)
        }
        
    }
}

#Preview {
    FilterSheetView()
//        .sheet(isPresented: showFilterSheetView, content: <#T##() -> View#>)
}
