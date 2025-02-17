//
//  ShoesSizeSheet.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 15.02.25.
//

import SwiftUI

struct ShoesSizeSheet: View {
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var viewModelFirestore: FirestoreViewModel
    @ObservedObject var errorHandler: ErrorHandler = .shared

    let columns = [(GridItem(.flexible())), (GridItem(.flexible()))]
    var product: Product

    var body: some View {
        Text("Wählen Sie eine Größe aus")
            .shadow(radius: 2, x: 0, y: 3)
        LazyVGrid(columns: columns) {
            ForEach(ShoesSizeEnum.allCases, id: \.self) { item in
                ZStack {
                    Rectangle()
                        .frame(width: 190, height: 60)
                        .foregroundStyle(item.getSizeToString() == viewModel.selectedSize ? .black : .white)
                        .border(.black)
                        .shadow(radius: 2, x: 0, y: 3)
                    Text(item.getSizeToString())
                        .bold()
                        .foregroundStyle(item.getSizeToString() == viewModel.selectedSize ? .white : .black)
                }
                .onTapGesture {
                    viewModel.selectedSize = item.getSizeToString()
                    viewModel.showHomeDetailSheet = false

                    let addNewCartProduct = Product(
                        id: product.id,
                        title: product.title,
                        price: product.price,
                        description: product.description,
                        images: product.images,
                        category: product.category,
                        size: viewModel.selectedSize
                    )
                    viewModel.selectedProduct = addNewCartProduct
                    
                    if let index = viewModelFirestore.cartList.firstIndex(where: {
                        $0.id == viewModel.selectedProduct.id && $0.size == viewModel.selectedSize
                    }) {
                        var updatedProduct = viewModelFirestore.cartList[index]
                        updatedProduct.numberOfProducts? += 1
                        viewModelFirestore.updateUserCart(product: updatedProduct)

                        viewModel.selectedSize = ""
                    } else {
                        viewModel.selectedProduct.cartID = UUID().uuidString
                        viewModelFirestore.updateUserCart(product: viewModel.selectedProduct)
                        viewModel.selectedSize = ""
                    }
                    viewModel.showSizes = false
                    viewModel.showSheet = false
                    viewModelFirestore.deleteUserFavorite(product: viewModel.selectedProduct)
                    viewModel.showShoesSizesOnCart = false
                }
            }
        }
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
    ShoesSizeSheet(viewModel: ProductViewModel(), viewModelFirestore: FirestoreViewModel(), product: ProductViewModel().testProduct)
}
