//
//  Fast_ShopApp.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 08.01.25.
//

import SwiftUI
import FirebaseCore

@main
struct Fast_ShopApp: App {
    
    init() {
//        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    @StateObject var viewModel = ProductViewModel()
    @StateObject var viewModelAdress = AdressViewModel()
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var viewModelFirestore = FirestoreViewModel()

    var body: some Scene {
        WindowGroup {
                VStack {
                    if !authViewModel.userIsLoggedIn {
                    LogInScreenView(authViewModel: authViewModel)
                            .tint(.black)
                } else {
                        TabView {
                            Tab("Home", systemImage: "house.fill") {
                                HomeView(viewModel: viewModel, viewModelFirestore: viewModelFirestore)
                            }
                            Tab("Search", systemImage: "magnifyingglass") {
                                SearchView(viewModel: viewModel, viewModelFirestore: viewModelFirestore)
                            }
                            Tab("Cart", systemImage: "bag") {
                                CartView(viewModel: viewModel, viewModelAdress: viewModelAdress, viewModelFirestore: viewModelFirestore)
                            }
                            .badge(viewModelFirestore.cartList.count)
                            Tab("Settings", systemImage: "person") {
                                SettingsView(viewModel: viewModel, viewModelAdress: viewModelAdress, viewModelFirestore: viewModelFirestore, authViewModel: authViewModel)
                            }
                        }
                        .tint(.black)
                        .onAppear {
                            viewModelFirestore.restartListeners()
                        }
                    }
                }
            .onAppear {
                authViewModel.checkLoggedIn()
            }
//            .onChange(of: authViewModel.user) { newUser in
//                          // Listener neu starten, wenn sich der User ändert
//                          viewModelFirestore.restartListeners()
//                      }
        }

    }
}
//    .overlay {
//        if showTab {
//            withAnimation {
//                Text("TEST")
//                    .font(.largeTitle)
//            }
//        }
//    }



//HomeView(viewModel: viewModel, isScrolling: $showTab)
//    .tabItem {
//        Label("Home", systemImage: "house")
//    }
//SearchView(viewModel: viewModel)
//    .tabItem {
//        Label("Search", systemImage: "magnifyingglass")
//    }
//CardView(viewModel: viewModel)
//    .tabItem {
//        Label("Cart", systemImage: "bag")
//    }
//SettingsView()
//    .tabItem {
//        Label("Settings", systemImage: "person")
//    }
