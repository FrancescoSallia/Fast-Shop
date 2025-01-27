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
    @ObservedObject var viewModel = ProductViewModel()
    var body: some View {
        Text("min und max Preis EUR")
        
        VStack {
            HStack {
//                Text("min: \(minPrice.formatted())")
                Text("min: \(viewModel.beispielArray[1].formatted())")
                Spacer()
                Text("max: \(viewModel.beispielArray[1].formatted())")
            }
            .padding()
            MultiValueSlider(value: $viewModel.beispielArray, minimumValue: viewModel.minPrice, maximumValue: viewModel.maxPrice, snapStepSize: 5 , outerTrackColor: .lightGray)
                .orientation(.horizontal)
                .padding()
                .onChange(of: viewModel.beispielArray, { oldValue, newValue in
                    Task {
                        try await viewModel.minMaxPriceFiltered()
                    }
                })
                .frame(height: 30)
            Picker("Kategorie", selection: $viewModel.selectedCategory) {
                Text("All Categories").tag(FilteredEnum.allCategories)
                Text("Clothes").tag(FilteredEnum.clothes)
                Text("Electronics").tag(FilteredEnum.electronics)
                Text("Furniture").tag(FilteredEnum.furniture)
                Text("Miscellaneous").tag(FilteredEnum.miscellaneous)
            }
            .onChange(of: viewModel.selectedCategory) { oldValue, newValue in
                Task {
                    try await viewModel.minMaxPriceFiltered()
                }
            }
        }
        List(viewModel.filteredCategory) { list in
            Text(list.title)
            Text(list.price.formatted())
        }
        Button {
            viewModel.selectedCategory = .allCategories
            viewModel.beispielArray = [0.0, 100.0]
        } label: {
            Text("RESET FILTER")
                .foregroundStyle(.black)
        }
        .buttonStyle(.borderedProminent)
        .tint(.yellow)
            .onAppear {
                Task {
                    try await viewModel.minMaxPriceFiltered()
                }
            }
    }
}

#Preview {
    @Previewable @State var showFilterSheetView = true

    FilterSheetView()
        .sheet(isPresented: $showFilterSheetView) {
            FilterSheetView()
        }
}
