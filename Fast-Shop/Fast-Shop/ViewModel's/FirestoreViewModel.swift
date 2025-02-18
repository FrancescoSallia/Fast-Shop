//
//  FirestoreViewModel.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 10.02.25.
//

import Foundation
import UserNotifications
import FirebaseAuth

@MainActor
class FirestoreViewModel: ObservableObject  {
    
    
    let firestore = FireManager.shared

    @Published var cartList: [Product] = []  // Dafür muss noch eine reset funktion erstellt werden!
    @Published var favoriteList: [Product] = []
    @Published var adressList: [Adress] = []
    @Published var oldOrderList: [Product] = []
    
    func restartListeners() {  //Die funktion, funktioniert nicht, der snapshoter setzt sich nicht zurück und man muss die app trotzdem immer wieder neustarten um die aktuellen daten des jeweiligen nutzers zu sehen.
        guard firestore.currentUser != nil else {
            print("Kein User eingeloggt, Listener werden nicht neu gestartet.")
            return
        }
        print("User eingeloggt, Listener werden neu gestartet.")
        cartSnapshotListener()
        favoriteSnapshotListener()
        adressSnapshotListener()
        oldOrderSnapshotListener()
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
    
    func updateUserAdress(adress: Adress) {
        Task {
            do {
                try await firestore.updateUserAdress(adress: adress)
            } catch {
                fatalError("update adress failed")
            }
        }
    }
    
    func deleteUserAdress(adress: Adress) {
        if let index = adressList.firstIndex(where: { $0.adressID == adress.adressID}) {
            let deleteAdress = adressList[index]
            Task {
                do {
                    print("delete Adress: \(deleteAdress)")
                    try await firestore.deleteUserAdress(adress: deleteAdress)
                } catch {
                    fatalError("delete Favorite item failed")
                }
            }
            
        }
    }
    
    private func adressSnapshotListener() {
        firestore.adressSnapshotListener { adress, error in
            if let error = error {
                print(error)
                return
            }
            self.adressList = adress
        }
    }
    
    func updateUserOldOrder(product: Product) {
        Task {
            do {
                try await firestore.updateUserOldOrder(product: product)
            } catch {
                fatalError("update old-Order failed")
            }
        }
    }
    
    private func oldOrderSnapshotListener() {
        firestore.oldOrderSnapshotListener { oldOrder, error in
            if let error = error {
                print(error)
                return
            }
            self.oldOrderList = oldOrder
        }
    }
    
    func isProductFavorite(product: Product) -> Bool {
        if favoriteList.firstIndex(where: { $0.id == product.id }) != nil {
            return true
        } else {
            return false
        }
    }
    
    
//MARK: Notification
    func checkCartAndScheduleNotification() {
        firestore.checkCartAndScheduleNotification()
    }
}
