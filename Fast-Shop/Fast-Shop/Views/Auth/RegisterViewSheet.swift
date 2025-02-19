//
//  RegisterViewSheet.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 06.02.25.
//

import SwiftUI

struct RegisterViewSheet: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject private var errorHandler = ErrorHandler.shared
    
    var body: some View {
        
        VStack(spacing: 20) {
                  Text("Registrierung")
                      .font(.largeTitle)
                      .fontWeight(.bold)
                  
            VStack(alignment: .leading) {
                Text("E-mail")
                    .padding(.bottom, -4)
                TextField("Email", text: $authViewModel.email)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .border(.primary)
                    .onSubmit {
                        return
                    }
            }
            VStack(alignment: .leading) {
                Text("Passwort")
                    .padding(.bottom, -4)
                SecureField("Passwort", text: $authViewModel.password)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .border(.primary)
                    .onSubmit {
                        return
                    }
            }
            VStack(alignment: .leading) {
                Text("Passwort wiederholen")
                    .padding(.bottom, -4)
                SecureField("Passwort wiederholen", text: $authViewModel.repeatedPassword)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .border(.primary)
                    .onSubmit {
                        authViewModel.register()
                    }
            }
                  
            Toggle(isOn: $authViewModel.acceptTerms) {
                      Text("Ich akzeptiere die AGB")
                  }
                  .padding(.horizontal)
                
            Button(action: {
                authViewModel.register()
                guard errorHandler.showError  else {
                    dismiss()
                    return
                }
                
            }) {
                Text("Registrieren")
                    .textCase(.uppercase)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(authViewModel.acceptTerms ? Color.primary.opacity(0.9) : .secondary.opacity(0.5))
                    .cornerRadius(3)
            }
            .disabled(!authViewModel.acceptTerms)
                  
                  Spacer()
              }
              .padding()
              .alert(isPresented: $errorHandler.showError) {
                  Alert(title: Text("Error"), message: Text(errorHandler.errorMessage), dismissButton: .default(Text("OK")))
              }
    }
}

#Preview {
    RegisterViewSheet(authViewModel: AuthViewModel())
}
