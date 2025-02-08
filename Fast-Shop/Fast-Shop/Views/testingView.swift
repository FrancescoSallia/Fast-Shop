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
    var body: some View {
        HStack(spacing: 0) {
            Button("-") {
                count -= 1
            }
            .padding()
            .border(.black)
            .frame(maxHeight: .infinity)
            Text("\(count)")
            .padding()
            .border(.black)
            .frame(maxHeight: .infinity)
            Button("+") {
                count += 1
            }
            .padding()
            .border(.black)
            .frame(maxHeight: .infinity)
            
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
