//
//  Fast_ShopApp.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 08.01.25.
//

import SwiftUI

@main
struct Fast_ShopApp: App {
    var body: some Scene {
        WindowGroup {
            
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "person")
                    }
            }
        }
    }
}
