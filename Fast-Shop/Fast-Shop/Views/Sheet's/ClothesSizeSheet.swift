//
//  SizeSheetView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 31.01.25.
//

import SwiftUI

struct ClothesSizeSheet: View {
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var viewModelFirestore: FirestoreViewModel
    @ObservedObject var errorHandler: ErrorHandler = .shared

    let columns = [(GridItem(.flexible())), (GridItem(.flexible()))]
    var product: Product

    var body: some View {
        Text("Wählen Sie eine Größe aus")
            .shadow(radius: 2, x: 0, y: 3)
        LazyVGrid(columns: columns) {
            ForEach(ClothesSizesEnum.allCases, id: \.self) { item in
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
//                        viewModel.user.cart.append(viewModel.selectedProduct)
                        viewModelFirestore.updateUserCart(product: viewModel.selectedProduct)

                        viewModel.selectedSize = ""
                    }
                    viewModel.showSizes = false
                    viewModel.showSheet = false
                    viewModelFirestore.deleteUserFavorite(product: viewModel.selectedProduct)
                    viewModel.showClothesSizesOnCart = false
                    viewModel.showToastCart.toggle()
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
    ClothesSizeSheet(viewModel: ProductViewModel(), viewModelFirestore: FirestoreViewModel(), product: ProductViewModel().testProduct)
}
