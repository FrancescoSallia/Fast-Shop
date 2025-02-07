//
//  SearchView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 20.01.25.
//

import SwiftUI

struct SearchView: View {
    let testProduct = Product(
        id: 1,
        title: "Classic Navy Blue Baseball Cap",
        price: 20.0,
        description: "Test Description",
        images: [
            "https://i.imgur.com/R3iobJA.jpeg",
            "https://i.imgur.com/Wv2KTsf.jpeg",
            "https://i.imgur.com/76HAxcA.jpeg",
        ],
        category: Category(
            id: 1,
            name: "Tools",
            image: "tools.png",
            creationAt: "2025-01-24T08:29:50.000Z",
            updatedAt: "2025-01-24T09:42:00.000Z"
        ), isFavorite: false,
        size: "",
        numberOfProducts: 0)
    @ObservedObject var viewModel: ProductViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            if !viewModel.filterIsActive {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.categories) { index in
                            Button {
                                //                            viewModel.filterIsActive = false
                                viewModel.filteredID = String(index.id)
                                if !viewModel.filterIsActive {
                                    Task {
                                        try await viewModel
                                            .getCategorieFilteredFromAPI()
                                    }
                                } else {
                                    Task {
                                        try await viewModel.minMaxPriceFiltered()
                                    }
                                }
                            } label: {
                                if viewModel.filteredID == "0" {
                                    Text("\(index.name)")
                                } else if viewModel.filteredID
                                    == String(index.id)
                                {
                                    Text("\(index.name)")
                                        .underline()
                                } else {
                                    Text("\(index.name)")
                                }
                            }
                            .font(.title3)
                            .padding()
                            .tint(.primary)
                        }
                    }
                    Divider()
                }
            }
            ScrollView(showsIndicators: false) {
                VStack {
                    LazyVGrid(columns: columns, spacing: -10) {
                        ForEach(viewModel.products) { filteredProduct in
                            NavigationLink(destination: {
                                ProductDetailView(
                                    product: filteredProduct,
                                    viewModel: viewModel)
                            }) {
                                VStack {
                                    HStack {
                                        ZStack(alignment: .bottom) {
                                            AsyncImage(
                                                url: URL(
                                                    string:
                                                        filteredProduct.images[
                                                            0])
                                            ) { pic in
                                                pic
                                                    .resizable()
                                                    .frame(
                                                        maxWidth: 400,
                                                        maxHeight: 250)
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            Button {
                                                viewModel.selectedProduct =
                                                    filteredProduct
                                                viewModel.showSheet.toggle()
                                            } label: {
                                                Image(
                                                    systemName:
                                                        "plus.circle.fill"
                                                )
                                                .padding(.bottom)
                                                .foregroundStyle(.yellow)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 3)

                                    VStack {
                                        HStack {
                                            Text("\(filteredProduct.title)")
                                                .font(.footnote)
                                            //frame machen
                                            Image(systemName: "bookmark")
                                        }

                                        HStack {
                                            Text(
                                                "\(filteredProduct.price.formatted())€"
                                            )
                                            .font(.footnote)
                                            .frame(width: 150)
                                            .padding(.bottom, 30)

                                            Spacer()
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                            .tint(.black)
                            //                            .onAppear {
                            //                                if viewModel.isLastItem(product: filteredProduct) {
                            //                                    Task {
                            //                                        try await viewModel.getProductsFromAPI()
                            //                                    }
                            //                                }
                            //                            }
                        }
                    }
                }
            }
            .refreshable {
                if !viewModel.filterIsActive {
                    Task {
                        try await viewModel.getCategorieFilteredFromAPI()
                    }
                } else {
                    Task {
                        try await viewModel.minMaxPriceFiltered()
                    }
                }

            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showFilterSheet.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            })
        }
        .sheet(
            isPresented: $viewModel.showSheet,
            content: {
                //            SelectedItemSheetView(productSelected: viewModel.selectedProduct ?? viewModel.testProduct )
                SelectedItemSheetView(viewModel: viewModel)
                    .presentationDetents([.height(600)])
                //                .presentationDetents([.medium, .large])
            }
        )
        .sheet(
            isPresented: $viewModel.showFilterSheet,
            content: {
                FilterSheetView(viewModel: viewModel)
                    //                .presentationDetents([.height(600)])
                    .presentationDetents([.medium, .large])
            }
        )
        .searchable(
            text: $viewModel.searchedText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search..."
        )
        .onChange(
            of: viewModel.searchedText,
            {
                Task {
                    try await viewModel.getCategorieFilteredFromAPI()
                }
            }
        )
        .onAppear {
            if !viewModel.filterIsActive {
                Task {
                    //                    try await viewModel.getProductsFromAPI()
                    try await viewModel.getCategoriesFromAPI()
                    try await viewModel.getCategorieFilteredFromAPI()
                }
            } else {
                Task {
                    try await viewModel.minMaxPriceFiltered()
                }
            }
        }
    }
}
#Preview {
    SearchView(viewModel: ProductViewModel())
}
