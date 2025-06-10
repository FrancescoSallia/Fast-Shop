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
    
   private func deleteUser() async throws {
        Task {
            do {
                try await manager.deleteUser(user: user!)
                self.user = nil
                self.password = ""
            } catch {
                print("Error deleting user: \(error)")
                errorHandler.handleError(error: error)
            }
        }
    }
    
    // der user muss sich nochmal authentifizieren bevor er sein account löschen kann
   private func reauthenticateUser() async -> Bool {
        do {
            // Re-authenticate user
            try await manager.reAuthenticateUser(currentPassword: self.password)
            return true
        } catch {
            print("Re-authentication or deletion failed: \(error)")
            errorHandler.handleError(error: error)
            return false
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
    
    
    func verifyAndDeleteUser(viewModelFirestore: FirestoreViewModel, selectedTab: @escaping () -> Void) async { //escaping ist eine callback funktion bei der du eine funktion oder ein wert von außen aufrufen kannst
            self.isLoading = true
            Task {
            let successfull = await reauthenticateUser()
            
            if successfull {
                    do {
                        try await viewModelFirestore.deleteUserCollection()
                        try await Task.sleep(for: .seconds(4))
                        selectedTab()
                        try await deleteUser()
                        showingReauthSheet.toggle()
                        
                    } catch {
                        errorHandler.handleError(error: error)
                        print("Fehler im successfull If statement (SettingsView)")
                    }
                    isLoading = false
                } else {
                    errorHandler.handleError(error: ErrorEnum.wrongPassword)
                    self.isLoading = false
//                    self.showingReauthSheet = false
                    self.password = ""
                }
            }
        }
}
