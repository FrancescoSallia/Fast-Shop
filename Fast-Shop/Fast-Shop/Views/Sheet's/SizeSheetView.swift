//
//  SizeSheetView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 31.01.25.
//

import SwiftUI

struct SizeSheetView: View {
    @ObservedObject var viewModel: ProductViewModel
    let columns = [(GridItem(.flexible())), (GridItem(.flexible()))]
    var product: Product

    var body: some View {
        Text("Wählen Sie eine Größe aus")
            .shadow(radius: 2, x: 0, y: 3)
        LazyVGrid(columns: columns) {
            ForEach(SizesEnum.allCases, id: \.self) { item in
                ZStack {
                    Rectangle()
                        .frame(width: 190, height: 60)
                        .foregroundStyle(item.rawValue == viewModel.selectedSize ? .black : .white)
                        .border(.black)
                        .shadow(radius: 2, x: 0, y: 3)
                    Text(item.rawValue)
                        .bold()
                        .foregroundStyle(item.rawValue == viewModel.selectedSize ? .white : .black)

                }
                .onTapGesture {
                    viewModel.selectedSize = item.rawValue
                    viewModel.showAlertSuccessfullAdded = true

                    let addNewCartProduct = Product(
                        id: product.id,
                        title: product.title,
                        price: product.price,
                        description: product.description,
                        images: product.images,
                        category: product.category,
                        size: viewModel.selectedSize,
                        cartID: nil
                    )
                    viewModel.selectedProduct = addNewCartProduct
                    
                    if let index = viewModel.user.cart.firstIndex(where: {
                        $0.id == viewModel.selectedProduct.id && $0.size == viewModel.selectedSize
                    }) {
                        var updatedProduct = viewModel.user.cart[index]
                        updatedProduct.numberOfProducts? += 1
                        viewModel.selectedSize = ""

                        viewModel.user.cart[index] = updatedProduct
                    } else {
                        viewModel.selectedProduct.cartID = UUID()
                        viewModel.user.cart.append(viewModel.selectedProduct)
                        viewModel.selectedSize = ""

                    }
                    viewModel.showSizes = false
                    viewModel.showSheet = false

                }
                
            }
            
        }
    }
}

#Preview {
    SizeSheetView(viewModel: ProductViewModel(), product: ProductViewModel().testProduct)
}



//Text("Wählen Sie eine Größe aus")
//    .shadow(radius: 2, x: 0, y: 3)
//LazyVGrid(columns: columns) {
//    ForEach(SizesEnum.allCases, id: \.self) { item in
//        ZStack {
//            Rectangle()
//                .frame(width: 190, height: 60)
//                .foregroundStyle(.white)
//                .border(.black)
//                .shadow(radius: 2, x: 0, y: 3)
//            Text(item.rawValue)
//                .bold()
//        }
//    }
//    
//}
