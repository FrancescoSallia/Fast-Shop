//
//  resetPasswordView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 06.02.25.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject private var errorHandler = ErrorHandler.shared

    var body: some View {
        VStack(alignment: .leading) {
            Text("E-mail")
                .padding(.bottom, -4)
            TextField("Email", text: $authViewModel.email)
                .frame(maxWidth: .infinity)
                .padding()
                .border(.primary)
        }
        .padding()
        Button(action: {
            authViewModel.resetPassword(email: authViewModel.email)
            dismiss()
        }) {
            Text("Passwort Zurücksetzen")
                .textCase(.uppercase)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.primary.opacity(0.9))
                .cornerRadius(3)
        }
        .padding()
        .alert(isPresented: $errorHandler.showError) {
            Alert(
                title: Text("Error"),
                message: Text(errorHandler.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    ResetPasswordView(authViewModel: AuthViewModel())
}
