//
//  SettingsView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 16.01.25.
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled: Bool = true
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
                        Toggle(isOn: $notificationsEnabled){
                            Text("Benachrichtigungen")
                        }
                        .onChange(of: notificationsEnabled) { value in
                            if value {
                                // Benachrichtigung einplanen, wenn der Toggle eingeschaltet ist
                                viewModelFirestore.checkCartAndScheduleNotification()
                            } else {
                                // Benachrichtigung entfernen, wenn der Toggle ausgeschaltet ist
                                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["cartReminder"])
                            }
                        }
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
                            authViewModel.logout()
                        }
                    }
                }
            }
            Button {
//                authViewModel.deleteUser()
                viewModel.confirmationDialogDelete.toggle()
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
        .confirmationDialog("Delete Account?", isPresented: $viewModel.confirmationDialogDelete) {
            Button("Account Löschen", role: .destructive) {
                authViewModel.deleteUser()
            }
            Button("Abbrechen", role: .cancel) {
                
            }
        }
    }
}

#Preview {
    SettingsView(viewModel: ProductViewModel(), viewModelAdress: AdressViewModel(), viewModelFirestore: FirestoreViewModel(), authViewModel: AuthViewModel())
}
