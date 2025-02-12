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
    @Published var isFavorited: Bool = false
    
    init() {
//        cartSnapshotListener()
//        favoriteSnapshotListener()
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
    
    func deleteUserCart(product: Product) {
        if let index = cartList.firstIndex(where: { $0.id == product.id}) {
            let deleteProduct = cartList[index]
            Task {
                do {
                    print("delete ID: \(deleteProduct)")
                    try await firestore.deleteUserCart(product: deleteProduct)
                } catch {
                    fatalError("delete Favorite item failed")
                }
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
    
    func isFavorited(productIndex: Int) -> Bool {
        // Prüfe, ob der Index gültig ist, um Abstürze zu vermeiden
        guard productIndex >= 0 && productIndex < favoriteList.count else {
            return false
        }
        
        // Überprüfe, ob das Produkt favorisiert ist
        return favoriteList[productIndex].isFavorite ?? false
    }}
