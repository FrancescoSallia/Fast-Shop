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
      let email: String = "user@example.com"
    @ObservedObject var viewModel: ProductViewModel

    var body: some View {
        NavigationStack {
                        VStack {
                            Form {
                                Section(header: Text("Einstellungen")) {
                                    Toggle("Benachrichtigungen", isOn: $notificationsEnabled)
                                    Toggle("Dunkler Modus", isOn: $isDarkMode)
                                    NavigationLink(destination: AdressView(viewModel: viewModel )) {
                                        Text("Meine Adressen")
                                    }
                                }
                                
                                Section(header: Text("Konto")) {
                                    Text("E-Mail: \(email)")
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
                                        // Logout action
                                    }
                                }
                            }
                        }
            Button(action: {}) {
                Text("Account löschen")
                    .foregroundColor(.red)
            }
          
        }
    }
}

#Preview {
    SettingsView(viewModel: ProductViewModel())
}
