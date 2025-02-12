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
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Einstellungen")) {
                        Toggle(
                            "Benachrichtigungen", isOn: $notificationsEnabled)
                        Toggle("Dunkler Modus", isOn: $isDarkMode)
                        NavigationLink(
                            destination: AdressView(viewModel: viewModelAdress)
                        ) {
                            Text("Meine Adressen")
                        }
                    }

                    Section(header: Text("Konto")) {
                        Text(
                            "E-Mail: \(authViewModel.user?.email ?? "Keine User-Email")"
                        )
                        //                                    Button(action: {}) {
                        //                                        Text("Account löschen")
                        //                                            .foregroundColor(.red)
                        //                                    }
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
    SettingsView(viewModel: ProductViewModel(), viewModelAdress: AdressViewModel(), authViewModel: AuthViewModel())
}
