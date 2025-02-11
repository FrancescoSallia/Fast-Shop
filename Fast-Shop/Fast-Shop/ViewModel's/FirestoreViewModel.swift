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
    @Published var favoriteList: [Product] = []
    
    init() {
        cartSnapshotListener()
        favoriteSnapshotListener()
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
    
    func updateUserFavorite(product: Product) {
        Task {
            do {
                try await firestore.updateUserFavorite(product: product)
//                getCartProducts()
            } catch {
                fatalError("update Cart failed")
            }
        }
    }
    
    func deleteUserFavorite(product: Product) {
        if let index = favoriteList.firstIndex(where: { $0.id == product.id}) {
            let deleteProduct = favoriteList[index]
            Task {
               do {
                   print("delete ID: \(deleteProduct)")
                   try await firestore.deleteUserFavorite(product: deleteProduct)
               } catch {
                   fatalError("delete Favorite item failed")
               }
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
    
    private func cartSnapshotListener() {
        firestore.cartSnapshotListener { products, error in
            if let error = error {
                print(error)
                return
            }
            self.cartList = products
            
        }
    }
    
    private func favoriteSnapshotListener() {
        firestore.favoriteSnapshotListener { products, error in
            if let error = error {
                print(error)
                return
            }
            self.favoriteList = products
            
        }
    }
}
