////
////  FilterSheetView.swift
////  Fast-Shop
////
////  Created by Francesco Sallia on 27.01.25.
////
//
//import SwiftUI
//import MultiSlider
//import SweeterSwift
//
//struct FilterSheetView: View {
//    @ObservedObject var viewModel = ProductViewModel()
//    var body: some View {
//        
//        VStack {
//            Text("min und max Preis EUR")
//            HStack {
//                Text("min: \(viewModel.minMaxValues[0].formatted())")
//                Spacer()
//                Text("max: \(viewModel.minMaxValues[1].formatted())")
//            }
//            .padding()
//            HStack {
//                MultiValueSlider(value: $viewModel.minMaxValues, minimumValue: viewModel.minPrice, maximumValue: viewModel.maxPrice, snapStepSize: 5 , outerTrackColor: .lightGray)
//                    .orientation(.horizontal)
//                    .thumbTintColor(.orange)
//                    .tint(.primary)
//                    .padding()
//                    .frame(height: 30)
//                
//                Picker("Kategorie", selection: $viewModel.filteredID) {
//                    Text("All Categories").tag(FilteredEnum.allCategories.caseCategorie)
//                    Text("Clothes").tag(FilteredEnum.clothes.caseCategorie)
//                    Text("Electronics").tag(FilteredEnum.electronics.caseCategorie)
//                    Text("Furniture").tag(FilteredEnum.furniture.caseCategorie)
//                    Text("Shoes").tag(FilteredEnum.shoes.caseCategorie)
//                    Text("Miscellaneous").tag(FilteredEnum.miscellaneous.caseCategorie)
//                }
//            }
//        }
//        HStack {
//            Button {
//                viewModel.selectedCategory = .allCategories
//                viewModel.minMaxValues = [0.0, 100.0]
//                viewModel.filteredID = viewModel.selectedCategory.caseCategorie
//                viewModel.showFilterSheet.toggle()
//                viewModel.filterIsActive = false
//                Task {
//                    try await viewModel.getCategorieFilteredFromAPI()
//                }
//            } label: {
//                Text("RESET FILTER")
//                    .foregroundStyle(.white)
//            }
//            .buttonStyle(.borderedProminent)
//            .tint(.orange)
//            Button {
//                viewModel.filterIsActive = true
//                Task {
//                    try await viewModel.minMaxPriceFiltered()
////                    try await viewModel.getCategorieFilteredFromAPI()
//                }
//                viewModel.showFilterSheet.toggle()
//            } label: {
//                Text("APPLY")
//                    .foregroundStyle(.white)
//            }
//            .buttonStyle(.borderedProminent)
//            .tint(.primary)
//            
//        }
//        .padding(.top, 100)
//            .onAppear {
//                Task {
////                    try await viewModel.minMaxPriceFiltered()
//                    try await viewModel.minMaxPriceFiltered()
//                }
//            }
//    }
//}
//
//#Preview {
//    @Previewable @State var showFilterSheetView = true
//
//    FilterSheetView()
//        .sheet(isPresented: $showFilterSheetView) {
//            FilterSheetView()
//        }
//}
