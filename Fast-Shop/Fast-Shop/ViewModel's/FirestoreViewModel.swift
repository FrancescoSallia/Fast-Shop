//
//  FirestoreViewModel.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 10.02.25.
//

import Foundation

@MainActor
class FirestoreViewModel: ObservableObject  {
    
    let firestore = FireManager.shared
    @Published var cartList: [Product] = []
    
    init() {
//        addSnapShotListener()
    }
    
    func updateUserCart(product: Product) {
        Task {
            do {
                try await firestore.updateUserCart(product: product)
//                getCartProducts()
            } catch {
                fatalError("update Cart failed")
            }
        }
    }
//    func getCartProducts() {
//        Task {
//            do {
//            self.cartList = try await firestore.getCartProducts()
//            } catch {
//                print(error)
//            }
//        }
//    }
    
    private func addSnapShotListener() {
        firestore.addSnapShotListener { products, error in
            if let error = error {
                print(error)
                return
            }
            self.cartList = products
            
        }
    }
}
