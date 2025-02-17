//
//  SettingsView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 16.01.25.
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled: Bool = true
    @State private var isDarkMode: Bool = false
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var viewModelAdress: AdressViewModel
    @ObservedObject var viewModelFirestore: FirestoreViewModel
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var errorHandler: ErrorHandler = .shared


    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Einstellungen")) {
                        Toggle(
                            "Benachrichtigungen", isOn: $notificationsEnabled)
                        NavigationLink(
                            destination: AdressView(viewModel: viewModelAdress, viewModelFirestore: viewModelFirestore)
                        ) {
                            Text("Meine Adressen")
                        }
                        NavigationLink(
                            destination: OldOrderView(viewModel: viewModel, viewModelFirestore: viewModelFirestore)
                        ) {
                            Text("Meine Bestellungen")
                        }
                    }

                    Section(header: Text("Konto")) {
                        Text(
                            "E-Mail: \(authViewModel.user?.email ?? "Keine User-Email")"
                        )
                    }
                }
                .navigationTitle("Einstellungen")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Ausloggen") {
                            //Den ViewModel wird beim ausloggen zurückgesetzt
                            viewModelFirestore.cartList.removeAll()
                            viewModelFirestore.favoriteList.removeAll()
                            viewModelFirestore.adressList.removeAll()
                            viewModelFirestore.oldOrderList.removeAll()
                                  
                            authViewModel.logout()
                            viewModelFirestore.restartListeners()
                        }
                    }
                }
            }
            Button {
                authViewModel.deleteUser()
            } label: {
                Text("Account löschen")
                    .foregroundColor(.red)
            }

        }
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
    SettingsView(viewModel: ProductViewModel(), viewModelAdress: AdressViewModel(), viewModelFirestore: FirestoreViewModel(), authViewModel: AuthViewModel())
}
