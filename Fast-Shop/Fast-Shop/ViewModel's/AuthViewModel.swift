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
    @Published var repeatedPassword = ""
    
    private var manager = FireManager.shared
    
    init() {
        checkLoggedIn()
    }
    
    var userIsLoggedIn: Bool {
        user != nil
    }
    func checkLoggedIn() {
        manager.currentUser?.reload()
        user = manager.currentUser
    }
    
    func register() {
        guard !email.isEmpty  && !password.isEmpty && password == repeatedPassword else {
            print("Fehler beim Registrieren")
            return
        }
        Task {
            do {
                user = try await manager.registerUser(email: email, password: password)
                self.email = ""
                self.password = ""
                self.repeatedPassword = ""
            } catch {
//                errorHandler.handleError(error: error)
                print(error)
            }
        }
    }
    
    func login() {
        Task {
            do {
                user = try await manager.loginUser(email: email, password: password)
                self.email = ""
                self.password = ""
            } catch {
                print(error)
            }
        }
    }
    
    func logout() {
        do {
            try manager.logoutUser()
            user = nil
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteUser() {
        Task {
            do {
                try await manager.deleteUser(user: user!)
                user = nil
            } catch {
                print(error)
            }
        }
    }


}
