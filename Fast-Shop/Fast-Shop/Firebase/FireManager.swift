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
    
    func registerUser(email: String, password: String) async throws -> User {
        let result = try await auth.createUser(withEmail: email, password: password)
        return result.user
    }
}
