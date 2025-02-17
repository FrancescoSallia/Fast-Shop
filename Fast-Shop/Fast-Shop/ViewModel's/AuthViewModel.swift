//
//  AuthViewModel.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 06.02.25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var email = ""
    @Published var password = ""
    @Published var repeatedPassword = ""
    
    private var manager = FireManager.shared
    private let errorHandler = ErrorHandler.shared

    
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
//            print("Fehler beim Registrieren")
            errorHandler.handleError(error: ErrorEnum.custom("Error registering, check the text fields again"))
            return
        }
        Task {
            do {
                user = try await manager.registerUser(email: email, password: password)
                try await manager.createFireUser(email: email)
                self.email = ""
                self.password = ""
                self.repeatedPassword = ""
            } catch {
                errorHandler.handleError(error: error)
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
                errorHandler.handleError(error: error)
            }
        }
    }
    
    func logout() {
        do {
            try manager.logoutUser()
            user = nil
        } catch {
            errorHandler.handleError(error: error)
        }
    }
    
    func deleteUser() {
        Task {
            do {
                try await manager.deleteUser(user: user!)
                user = nil
            } catch {
                errorHandler.handleError(error: error)
            }
        }
    }
    func resetPassword(email: String) {
        guard !email.isEmpty else {
            errorHandler.showError.toggle()
            return
        }
        manager.resetPassword(email: email)
        self.email = ""
    }


}
