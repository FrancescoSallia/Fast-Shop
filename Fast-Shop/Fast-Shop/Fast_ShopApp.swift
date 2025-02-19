//
//  Fast_ShopApp.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 08.01.25.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound],
            completionHandler: { _, _ in }
        )
        
        return true
    }
    
    // MARK: - UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if response.actionIdentifier == "SHOW_CART_ACTION" || response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            if let targetView = userInfo["targetView"] as? String, targetView == "CartView" {
                // Sende eine Notification, um zur CartView zu navigieren
                NotificationCenter.default.post(name: Notification.Name("NavigateToCart"), object: nil)
            }
        }
        completionHandler()
    }
}


@main
struct Fast_ShopApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    init() {
//        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    @StateObject var viewModel = ProductViewModel()
    @StateObject var viewModelAdress = AdressViewModel()
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var viewModelFirestore = FirestoreViewModel()
    @State private var selectedTab = 0


    var body: some Scene {
        WindowGroup {
                VStack {
                    if !authViewModel.userIsLoggedIn {
                    LogInScreenView(authViewModel: authViewModel)
                            .tint(.black)
                } else {
                    TabView(selection: $selectedTab) {
                        Tab("Home", systemImage: "house.fill", value: 0) {
                                HomeView(viewModel: viewModel, viewModelFirestore: viewModelFirestore)
                            }
                        
                            Tab("Search", systemImage: "magnifyingglass", value: 1) {
                                SearchView(viewModel: viewModel, viewModelFirestore: viewModelFirestore)
                            }
                        
                            Tab("Cart", systemImage: "bag", value: 2) {
                                CartView(viewModel: viewModel, viewModelAdress: viewModelAdress, viewModelFirestore: viewModelFirestore)
                            }
                            .badge(viewModelFirestore.cartList.count)
                        
                            Tab("Settings", systemImage: "person", value: 3) {
                                SettingsView(viewModel: viewModel, viewModelAdress: viewModelAdress, viewModelFirestore: viewModelFirestore, authViewModel: authViewModel)
                            }
                        }
                        .tint(.black)
                        .onAppear {
                            viewModelFirestore.restartListeners()
                            viewModelFirestore.checkCartAndScheduleNotification() //Prüft ob was im Warenkorb drinne ist um Die notification zu Starten
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("NavigateToCart"))) { _ in  // onReceive schaut nach änderungen vom publisher um änderungen zu aktualisieren
                            // Wenn die Notification ankommt, auf Cart umschalten beim drauf tippen
                            selectedTab = 2
                        }
                    }
                }
                .overlay(
                    VStack {
                        Spacer()
                        if viewModel.showToastCart {
                            Text("Artikel wurde zum Warenkorb hinzugefügt! ✅")
                                .font(.subheadline)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                                .shadow(radius: 6)
                            
                        }  else if viewModel.showToastCartRemoved {  // Nur wenn explizit entfernt wurde!
                                Text("Artikel wurde vom Warenkorb entfernt! ✅")
                            
                                .font(.subheadline)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                                .shadow(radius: 6)
                            
                        } else if viewModel.showToastFavorite {
                            HStack {
                                Text("Artikel wurde zu Favoriten hinzugefügt!")
                                Image(systemName: "bookmark.fill")
                            }
                                .font(.subheadline)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                                .shadow(radius: 6)
                            
                        } else if viewModel.showToastFavoriteRemoved {  // Nur wenn explizit entfernt wurde!
                            HStack {
                                Text("Artikel wurde von den Favoriten entfernt!")
                                Image(systemName: "bookmark")
                            }
                                .font(.subheadline)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                                .shadow(radius: 6)
                        }
                    }
                     .padding(.bottom, 92)
                )
                .onChange(of: viewModel.showToastCart) { newValue in
                    if newValue {
                        Task {
                            try await Task.sleep(for: .seconds(2))
                            withAnimation {
                                viewModel.showToastCart = false
                            }
                        }
                    }
                }
                .onChange(of: viewModel.showToastFavorite) { newValue in
                    if newValue {
                        Task {
                            try await Task.sleep(for: .seconds(2))
                            withAnimation {
                                viewModel.showToastFavorite = false
                            }
                        }
                    }
                }
                .onChange(of: viewModel.showToastFavoriteRemoved) { newValue in
                    if newValue {
                        Task {
                            try await Task.sleep(for: .seconds(2))
                            withAnimation {
                                viewModel.showToastFavoriteRemoved = false
                            }
                        }
                    }
                }
                .onChange(of: viewModel.showToastCartRemoved) { newValue in
                    if newValue {
                        Task {
                            try await Task.sleep(for: .seconds(2))
                            withAnimation {
                                viewModel.showToastCartRemoved = false
                            }
                        }
                    }
                }
            .onAppear {
                authViewModel.checkLoggedIn()
            }
            .preferredColorScheme(.light)
        }
    }
}
