//
//  Fast_ShopApp.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 08.01.25.
//

import SwiftUI

@main
struct Fast_ShopApp: App {
    @StateObject var viewModel = ProductViewModel()
    @State var showTab: Bool = true

    var body: some Scene {
        WindowGroup {
            
                TabView {
                    Tab("Home", systemImage: "house.fill"){
                        HomeView(isScrolling: $showTab)
                    }
                    Tab("Search", systemImage: "magnifyingglass"){
                        SearchView(viewModel: viewModel)
                    }
                    Tab("Cart", systemImage: "bag"){
                        CartView(viewModel: viewModel)
                    }
                    Tab("Settings", systemImage: "person"){
                        SettingsView()
                    }
                
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
