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

    var body: some Scene {
        WindowGroup {
            
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                APITestView()
                    .tabItem {
                        Label("API Test", systemImage: "arrowshape.turn.up.right.fill")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "person")
                    }
            }
        }
    }
}
