//
//  FireManager.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 06.02.25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class FireManager {
    
    static let shared = FireManager()

    var currentUser: User? {
        auth.currentUser
    }
    // Es ist nicht mehr möglich, eine eigene Instanz von der Klasse zu erstellen, sondern man muss sich immer die shared Instanz holen.
    private init() {}

    private let auth = Auth.auth()
    let store = Firestore.firestore()
    
//MARK: Auth-Section
    func registerUser(email: String, password: String) async throws -> User {
        let result = try await auth.createUser(withEmail: email, password: password)
        return result.user
    }
    func loginUser(email: String, password: String) async throws -> User {
        let result = try await auth.signIn(withEmail: email, password: password)
        return result.user
    }
    func logoutUser() throws {
        try auth.signOut()
    }
    func deleteUser(user: User) async throws {
        try await user.delete()
    }
    func resetPassword(email: String) {
        auth.sendPasswordReset(withEmail: email)
        
    }

//MARK: Firestore-Section
    
    func createFireUser(email: String) async throws {
        let fireUser = FireUser(email: email)
        try store
            .collection("users")
            .addDocument(from: fireUser)
    }
    
    func productToDictionary(product: Product) -> [String: Any] {
      return [
        "id": product.id,
        "title": product.title,
        "price": product.price,
        "description": product.description,
        "images": product.images,
        "category": product.category,
        "isFavorite": product.isFavorite ?? false,
        "size": product.size ?? SizesEnum.S,
        "numberOfProducts": product.numberOfProducts ?? 0,
        "cartID": product.cartID ?? "keine cartID"
      ]
    }
    
    func updateUserCart(product: Product) async throws {
        guard let uid = currentUser?.uid else {
            fatalError("no current user")
        }
        let productData = productToDictionary(product: product)
        let userRef = store.collection("users").document(uid)
       
//        let newProduct = Product(
//            id: product.id,
//            title: product.title,
//            price: product.price,
//            description: product.description,
//            images: product.images,
//            category: product.category,
//            isFavorite: product.isFavorite,
//            size: product.size,
//            numberOfProducts: product.numberOfProducts,
//            cartID: product.cartID
//        )
       
        do {
            try await userRef
                .updateData(["cart": FieldValue.arrayUnion([productData])])
//                .setData(from: product)
        } catch let error {
          print("Error writing city to Firestore: \(error)")
        }
    }
}
