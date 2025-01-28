//
//  SelectedItemSheetView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 25.01.25.
//

import SwiftUI

struct SelectedItemSheetView: View {
    
    @ObservedObject var viewModel = ProductViewModel()
    
    let sizes: [String] = ["XS","S", "M", "L", "XL", "XXL"]
    let columns = [(GridItem(.flexible())), (GridItem(.flexible()))]
    let productSelected: Product
    
    var body: some View {
        VStack {
            Text(productSelected.title)
                .font(.headline)
            Text("\(productSelected.price.formatted())€")
            ScrollView(.horizontal) {
                HStack {
                    ForEach(productSelected.images, id: \.self) { product in
                            AsyncImage(url: URL(string: product)) { pic in
                            pic
                                .resizable()
                                .frame(width: 122, height: 180)
                                .foregroundStyle(.red)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
            .padding(.leading)
            
            if productSelected.category.id == 1{
                Text("Wählen Sie eine Größe aus")
                LazyVGrid(columns: columns) {
                    ForEach(sizes, id: \.self) { item in
                        HStack {
                            ZStack {
                                Rectangle()
                                    .frame(width: 220, height: 50)
                                    .border(.black, width: 2)
                                    .foregroundStyle(.white)
                                    .offset(x:10)
                                Text(item)
                                
                            }
                        }
                    }
                }
            } else if productSelected.category.id == 2{
                Text("Electronik")
            } else if productSelected.category.id == 3{
                Text("Möbel")
            } else if productSelected.category.id == 4{
                Text("Schuhe")
            } else if productSelected.category.id == 5{
                Text("Miscellaneous")
            } else {
                Text("Andere Dinge")

            }
                
        }
        .onAppear {
            Task {
               try await viewModel.getProductsFromAPI()
            }
        }
    }
}

#Preview {
    let testProduct = Product(
        id: 1,
        title: "Classic Navy Blue Baseball Cap",
        price: 20.0,
        description: "Test Description",
        images: [
        "https://i.imgur.com/R3iobJA.jpeg",
        "https://i.imgur.com/Wv2KTsf.jpeg",
        "https://i.imgur.com/76HAxcA.jpeg"
      ],
        category: Category(
            id: 1,
            name: "Tools",
            image: "tools.png",
            creationAt: "2025-01-24T08:29:50.000Z",
            updatedAt: "2025-01-24T09:42:00.000Z"
        ))

    SelectedItemSheetView(viewModel: ProductViewModel(), productSelected: testProduct)
        
}
