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
                            destination: OldOrderView(viewModelFirestore: viewModelFirestore)
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
                            authViewModel.logout()
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
    }
}

#Preview {
    SettingsView(viewModel: ProductViewModel(), viewModelAdress: AdressViewModel(), viewModelFirestore: FirestoreViewModel(), authViewModel: AuthViewModel())
}
