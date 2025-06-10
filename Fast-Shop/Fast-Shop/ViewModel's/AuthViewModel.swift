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
    @Published var acceptTerms: Bool = false
    @Published var notificationsEnabled: Bool = true
    @Published var focusedField: TextFieldFocusEnum? = nil
    @Published var showingReauthSheet = false
    @Published var isLoading: Bool = false

    
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
                notificationsEnabled = true
                self.email = ""
                self.password = ""
                
            } catch {
                errorHandler.handleError(error: error)
            }
        }
    }
    
    func logout() {
        do {
            self.email = ""
            self.password = ""
            notificationsEnabled = false
            try manager.logoutUser()
            user = nil
        } catch {
            errorHandler.handleError(error: error)
        }
    }
    
//    func deleteUser() async {
//        Task {
//            do {
//                try await manager.deleteUser(user: user!)
//                user = nil
//            } catch {
//                print("Error deleting user: \(error)")
//                errorHandler.handleError(error: error)
//            }
//        }
//    }
    
    // der user muss sich nochmal authentifizieren bevor er sein account löschen kann
    func reauthenticateAndDeleteUser() async {
        Task {
            do {
                // Re-authenticate user
                try await manager.reAuthenticateUser(currentPassword: self.password)
                
                // Now it's safe to delete the user
                try await manager.deleteUser(user: user!)
                self.user = nil
                self.password = ""
                
            } catch {
                print("Re-authentication or deletion failed: \(error)")
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
