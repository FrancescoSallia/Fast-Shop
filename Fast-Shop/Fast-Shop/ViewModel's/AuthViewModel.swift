//
//  AuthViewModel.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 06.02.25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var email = ""
    @Published var password = ""
    
    private var manager = FireManager.shared
    
    var userIsLoggedIn: Bool {
        user != nil
    }
    
    func register() {
        Task {
            do {
                user = try await manager.registerUser(email: email, password: password)
                self.email = ""
                self.password = ""
            } catch {
//                errorHandler.handleError(error: error)
                print(error)
            }
        }
    }

}
