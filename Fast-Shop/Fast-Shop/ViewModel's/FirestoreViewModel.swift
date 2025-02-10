//
//  FirestoreViewModel.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 10.02.25.
//

import Foundation

@MainActor
class FirestoreViewModel: ObservableObject {
    
    let firestore = FireManager.shared
    
    func updateUserCart(product: Product) {
        Task {
            do {
                try await firestore.updateUserCart(product: product)
            } catch {
                fatalError("update Cart failed")
            }
        }
    }
}
