//
//  FilterSheetView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 27.01.25.
//

import SwiftUI
import MultiSlider
import SweeterSwift

struct FilterSheetView: View {
    @State private var price = 50.0
    @State private var minPrice = 10.0
    @State private var maxPrice = 100.0
    @State private var beispielArray: [CGFloat] = [0.0, 100.0]
    @State var selectedCategory : FilteredEnum = .allCategories
     

    @State private var isEditing = false
    @State var showFilterSheetView: Bool = false
    @State var productList: [Product] = []
    
    var body: some View {
        Text("min und max Preis EUR")
        
        VStack {
            HStack {
//                Text("min: \(minPrice.formatted())")
                Text("min: \(beispielArray[0].formatted())")
                Spacer()
                Text("max: \(beispielArray[1].formatted())")
            }
            .padding()
            MultiValueSlider(value: $beispielArray, minimumValue: minPrice, maximumValue: maxPrice, snapStepSize: 5 , outerTrackColor: .lightGray)
                .orientation(.horizontal)
                .padding()
                .onChange(of: beispielArray, { oldValue, newValue in
                    Task {
                        try await minMaxPriceFiltered()
                    }
                })
                .frame(height: 30)
            Picker("Kategorie", selection: $selectedCategory) {
                Text("All Categories").tag(FilteredEnum.allCategories)
                Text("Clothes").tag(FilteredEnum.clothes)
                Text("Electronics").tag(FilteredEnum.electronics)
                Text("Furniture").tag(FilteredEnum.furniture)
                Text("Miscellaneous").tag(FilteredEnum.miscellaneous)
            }
            .onChange(of: selectedCategory) { oldValue, newValue in
                Task {
                    try await minMaxPriceFiltered()
                }
            }
        }
        List(productList) { list in
            Text(list.title)
            Text(list.price.formatted())
        }
        Button {
            selectedCategory = .allCategories
            beispielArray = [0.0, 100.0]
        } label: {
            Text("RESET FILTER")
                .foregroundStyle(.black)
        }
        .buttonStyle(.borderedProminent)
        .tint(.yellow)
            .onAppear {
                Task {
                    try await minMaxPriceFiltered()
                }
            }
    }
    
     func minMaxPriceFiltered() async throws {
         guard let url = URL(string: "https://api.escuelajs.co/api/v1/products/?price_min=\(String(format: "%.2f", beispielArray[0]))&price_max=\(String(format: "%.2f", beispielArray[1]))&categoryId=\(selectedCategory.caseCategorie)") else {throw errorEnum.invalidURL}
        
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
