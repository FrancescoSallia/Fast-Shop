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
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var viewModelFirestore = FirestoreViewModel()
    @State var showTab: Bool = true
    @State var isLogged: Bool = false

    var body: some Scene {
        WindowGroup {
                VStack {
                    if !authViewModel.userIsLoggedIn {
                    LogInScreenView(authViewModel: authViewModel)
                } else {
                        TabView {
                            Tab("Home", systemImage: "house.fill"){
                                HomeView(isScrolling: $showTab)
                                //                        APITestView()
                            }
                            Tab("Search", systemImage: "magnifyingglass"){
                                SearchView(viewModel: viewModel, viewModelFirestore: viewModelFirestore)
                                    .sheet(isPresented: $viewModel.showAlertSuccessfullAdded, content: {
                                        IsSuccessfullSheet(viewModel: viewModel)
                                            .presentationDetents([.height(60)])
                                    })
                            }
                            Tab("Cart", systemImage: "bag"){
                                CartView(viewModel: viewModel, viewModelFirestore: viewModelFirestore)
                                //                            .toolbarVisibility(showTab ? .hidden : .visible, for: .tabBar)
                            }
                            Tab("Settings", systemImage: "person"){
                                SettingsView(viewModel: viewModel, authViewModel: authViewModel)
                                //                          LogInScreenView()
                            }
                            
                        }
                    }
                }
            .onAppear {
                authViewModel.checkLoggedIn()
                
            }
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
