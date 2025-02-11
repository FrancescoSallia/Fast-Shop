//
//  testingView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 08.02.25.
//

import SwiftUI

struct testingView: View {
    
    @ObservedObject var viewModel: ProductViewModel
    @State var count = 0
    @State var testProducteArray: [Product] = [
        Product(
        id: 1,
        title: "Classic Navy Blue Baseball Cap, Classic Navy Blue Baseball Cap",
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
        ), isFavorite: false,
        size: "",
        numberOfProducts: 0
    ),
        Product(
        id: 2,
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
        ), isFavorite: false,
        size: "",
        numberOfProducts: 0
    ),
        Product(
        id: 3,
        title: "Classic Navy Blue Baseball Cap, Classic Navy Blue Baseball Cap",
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
        ), isFavorite: false,
        size: "",
        numberOfProducts: 0
    )
]

    var body: some View {
      
//        ScrollView {
        List {
            ForEach(testProducteArray) { item in
                HStack {
                    AsyncImage(url: URL(string: item.images.first ?? "NO Image")) { pic in
                        pic
                            .image?.resizable()
                            .frame(maxWidth: 160, maxHeight: 230)
                    }
                    VStack {
                        Text(item.title)
                        
                        HStack {
                            Button("-") {
                                
                            }
                            Text("0")
                            Button("+") {
                                
                            }
                        }
                    }
                    //                }
                }
            }
            .listStyle(.plain)
        }
    }
}
#Preview {
    testingView(viewModel: ProductViewModel())
}



//MARK: Diese view unten war bei cartView als buttons drinne!

//                            HStack {
//                                ZStack {
//                                    Rectangle()
//                                        .frame(width: 30, height: 30)
//                                        .foregroundStyle(.white)
//                                        .border(.black)
//
//                                    //FIXME: Wenn beide buttons if let index funktion an ist, denn wird die anzahl weder erhöht noch reduziert
//                                    Button("-") {
//                                        //                                    if let index = viewModel.user.cart.firstIndex(where: {$0.id == product.id}) {
//                                        //                                        viewModel.user.cart[index].numberOfProducts? -= 1
//                                        //                                    }
//                                        Task {
//                                            try await viewModel.getProductsFromAPI()
//                                        }
//                                    }
//                                    .tint(.primary)
//                                }
//                                ZStack {
//                                    Rectangle()
//                                        .frame(width: 30, height: 30)
//                                        .foregroundStyle(.white)
//                                        .border(.black)
//                                    Text("\(product.numberOfProducts ?? 0)")
//                                        .fontDesign(.serif)
//                                        .fontWeight(.thin)
//                                }
//                                ZStack {
//                                    Rectangle()
//                                        .frame(width: 30, height: 30)
//                                        .foregroundStyle(.white)
//                                        .border(.black)
//                                    Button("+") {
//                                        if let index = viewModel.user.cart.firstIndex(where: {$0.cartID == product.cartID}) {
//                                            viewModel.user.cart[index].numberOfProducts? += 1
//                                        }
//                                        Task {
//                                            try await viewModel.getProductsFromAPI()
//                                        }
//                                    }
//                                    .tint(.primary)
//                                }
//                            }
