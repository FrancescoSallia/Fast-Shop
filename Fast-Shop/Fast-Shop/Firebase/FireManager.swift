//
//  FireManager.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 06.02.25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class FireManager {
    
    static let shared = FireManager()

    var currentUser: User? {
        auth.currentUser
    }
    // Es ist nicht mehr möglich, eine eigene Instanz von der Klasse zu erstellen, sondern man muss sich immer die shared Instanz holen.
    private init() {}

    private let auth = Auth.auth()
    let store = Firestore.firestore()
    
    
//MARK: Auth-Section
    
    func registerUser(email: String, password: String) async throws -> User {
        let result = try await auth.createUser(withEmail: email, password: password)
        return result.user
    }
    func loginUser(email: String, password: String) async throws -> User {
        let result = try await auth.signIn(withEmail: email, password: password)
        return result.user
    }
    func logoutUser() throws {
        try auth.signOut()
    }
    func deleteUser(user: User) async throws {
        try await user.delete()
    }
    func resetPassword(email: String) {
        auth.sendPasswordReset(withEmail: email)
    }

//MARK: Firestore-Section

    func createFireUser(email: String) async throws {
        // Sicherstellen, dass der User eingeloggt ist und eine UID hat
        guard let uid = currentUser?.uid else {
            fatalError("Kein aktueller User oder keine UID vorhanden")
        }

        let docRef = store.collection("users").document(uid) // Verwende die UID als Dokument-ID
        let fireUser = FireUser(email: email)
        fireUser.id = uid // Setzt die ID auch im Objekt
        
        // Speichern mit der UID als Dokument-ID
        try docRef.setData(from: fireUser)

    }
    
//MARK: Delete all User Collections Section
    func deleteUserCollection() async throws {
        guard let uid = currentUser?.uid else {
            fatalError("Kein aktueller User oder keine UID vorhanden")
        }
        //Ruft alle privaten functionen auf, damit die subCollections erstmal gelöscht werden, danach die endgültige user collection!
        try await allUserCollectionDelete()
        
        try await store
            .collection("users")
            .document(uid)
            .delete()
    }
    
     private func allUserCollectionDelete() async throws {
        
            do {
                try await deleteUserCollectionAdress()
                try await deleteUserCollectionCart()
                try await deleteUserCollectionFavorite()
                try await deleteUserCollectionOldOrders()
            } catch {
                print("Fehler beim Löschen einer der User Collections: \(error) schau in die private funktion von FireManager rein")
            }
    }
    
    private func deleteUserCollectionCart() async throws {
        guard let uid = currentUser?.uid else {
            fatalError("Kein aktueller User oder keine UID vorhanden")
        }
        
        let userRef = store.collection("users").document(uid).collection("Cart")
        
        // Abrufen aller Dokumente in der Cart-Collection
        let snapshot = try await userRef.getDocuments()
        
        // Löschen jedes Dokuments in der Cart-Collection
        for document in snapshot.documents {
            // Löschen des Dokuments anhand der Dokument-ID
            do {
                try await document.reference.delete()
                print("Dokument mit ID \(document.documentID) gelöscht")
            } catch {
                print("FEHLER BEIM LÖSCHEN DER CartList: \(error)")
            }
        }
    }
    
    private func deleteUserCollectionFavorite() async throws {
        guard let uid = currentUser?.uid else {
            fatalError("Kein aktueller User oder keine UID vorhanden")
        }
        
        let userRef = store.collection("users").document(uid).collection("Favorite")
        
        // Abrufen aller Dokumente in der Cart-Collection
        let snapshot = try await userRef.getDocuments()
        
        // Löschen jedes Dokuments in der Cart-Collection
        for document in snapshot.documents {
            // Löschen des Dokuments anhand der Dokument-ID
            do {
                try await document.reference.delete()
                print("Dokument mit ID \(document.documentID) gelöscht")
            } catch {
                print("FEHLER BEIM LÖSCHEN DER FavoritenList: \(error)")
            }
        }
    }
    
    private func deleteUserCollectionAdress() async throws {
        guard let uid = currentUser?.uid else {
            fatalError("Kein aktueller User oder keine UID vorhanden")
        }
        
        let userRef = store.collection("users").document(uid).collection("Adress")
        
        // Abrufen aller Dokumente in der Cart-Collection
        let snapshot = try await userRef.getDocuments()
        
        // Löschen jedes Dokuments in der Cart-Collection
        for document in snapshot.documents {
            // Löschen des Dokuments anhand der Dokument-ID
            do {
                try await document.reference.delete()
                print("Dokument mit ID \(document.documentID) gelöscht")
            } catch {
                print("FEHLER BEIM LÖSCHEN DER AdressList: \(error)")
            }
        }
    }
    
    private func deleteUserCollectionOldOrders() async throws {
        guard let uid = currentUser?.uid else {
            fatalError("Kein aktueller User oder keine UID vorhanden")
        }
        
        let userRef = store.collection("users").document(uid).collection("Old-Orders")
        
        // Abrufen aller Dokumente in der Cart-Collection
        let snapshot = try await userRef.getDocuments()
        
        // Löschen jedes Dokuments in der Cart-Collection
        for document in snapshot.documents {
            // Löschen des Dokuments anhand der Dokument-ID
            do {
                try await document.reference.delete()
                print("Old Orders-Dokument mit ID \(document.documentID) gelöscht")
            } catch {
                print("FEHLER BEIM LÖSCHEN DER OLD ORDERS: \(error)")
            }
        }
    }
    
    func updateUserCart(product: Product) async throws { //Fügt ein Product in der liste von Firebase ein
        guard let uid = currentUser?.uid else {
            fatalError("no current user")
        }
        
        var eigeneID = ""
        let userRef = store.collection("users").document(uid).collection("Cart")
        
        do {
            eigeneID = product.fireID!
           try userRef
                .document(eigeneID)
                .setData(from: product)
            print("fireID: \(eigeneID)")
        } catch {
            print(error)
        }
    }
    
    func deleteUserCart(product: Product) async throws {    //Löscht ein Product von der liste in Firebase raus
        guard let uid = currentUser?.uid else {
            fatalError("no current user")
        }
        
        let userRef = store.collection("users").document(uid).collection("Cart")
        
        do {
            try await userRef
                .document(product.fireID!)
                .delete()
        } catch {
            print(error)
        }
    }
    
    func updateUserFavorite(product: Product) async throws {
        guard let uid = currentUser?.uid else {
            fatalError("no current user")
        }
        var eigeneID = ""
        let userRef = store.collection("users").document(uid).collection("Favorite")
        
        do {
            eigeneID = product.fireID!
            try userRef
                .document(eigeneID)
                .setData(from: product)
        } catch {
            print(error)
        }
    }
    
    func deleteUserFavorite(product: Product) async throws {
        guard let uid = currentUser?.uid else {
            fatalError("no current user")
        }
        
        let userRef = store.collection("users").document(uid).collection("Favorite")
        
        do {
            try await userRef
                .document(product.fireID!)
                .delete()
        } catch {
            print(error)
        }
    }
    
    func cartSnapshotListener(compleation: @escaping ([Product], Error?) -> Void) { //Beobachtet ob sich die Liste ändert um es in echtzeit zu akutalisieren
        guard let uid = currentUser?.uid else {
            compleation([], nil)
            return
        }
        let userRef = store.collection("users").document(uid).collection("Cart")
        userRef
            .addSnapshotListener(includeMetadataChanges: false) { snapshot, error in
                if let error = error {
                    print("Error listening for changes: \(error)")
                    compleation([], error)
                    return
                }
                guard let snapshot else {
                    fatalError("snapshot ist leer")
                }
                let products = snapshot
                    .documents
                    .compactMap { product in
                        try? product.data(as: Product.self)
                    }
                compleation(products, nil)
              
                // Prüft nach jeder Änderung, ob eine Notification geplant oder entfernt werden muss
                self.checkCartAndScheduleNotification()
            }
    }
    
    func favoriteSnapshotListener(compleation: @escaping ([Product], Error?) -> Void) {
        guard let uid = currentUser?.uid else {
            compleation([], nil)
            return        }
        let userRef = store.collection("users").document(uid).collection("Favorite")
        userRef
            .addSnapshotListener(includeMetadataChanges: false) { snapshot, error in
                if let error = error {
                    print("Error listening for changes: \(error)")
                    compleation([], error)
                    return
                }
                guard let snapshot else {
                    fatalError("snapshot ist leer")
                }
                let products = snapshot
                    .documents
                    .compactMap { product in
                        try? product.data(as: Product.self)
                    }
                compleation(products, nil)
            }
    }
    
    func updateUserAdress(adress: Adress) async throws {
        guard let uid = currentUser?.uid else {
            fatalError("no current user")
        }
        
        var eigeneID = ""
        let userRef = store.collection("users").document(uid).collection("Adress")
        
        do {
            eigeneID = adress.adressID
           try userRef
                .document(eigeneID)
                .setData(from: adress)
        } catch {
            print(error)
        }
    }
    
    func deleteUserAdress(adress: Adress) async throws {
        guard let uid = currentUser?.uid else {
            fatalError("no current user")
        }
        
        let userRef = store.collection("users").document(uid).collection("Adress")
        
        do {
            try await userRef
                .document(adress.adressID)
                .delete()
        } catch {
            print(error)
        }
    }
    
    func adressSnapshotListener(compleation: @escaping ([Adress], Error?) -> Void) {
        guard let uid = currentUser?.uid else {
            compleation([], nil)
            return
        }
        
        let userRef = store.collection("users").document(uid).collection("Adress")
        userRef
            .addSnapshotListener(includeMetadataChanges: false) { snapshot, error in
                if let error = error {
                    print("Error listening for changes: \(error)")
                    compleation([], error)
                    return
                }
                guard let snapshot else {
                    fatalError("snapshot ist leer")
                }
                let adress = snapshot
                    .documents
                    .compactMap { oneAdress in
                        try? oneAdress.data(as: Adress.self)
                    }
                compleation(adress, nil)
            }
    }
    
    func updateUserOldOrder(product: Product) async throws {     //Fügt ein Product in der liste von Firebase ein
        guard let uid = currentUser?.uid else {
            fatalError("no current user")
        }
        
        var eigeneID = ""
        let userRef = store.collection("users").document(uid).collection("Old-Orders")
        
        do {
            eigeneID = product.oldOrderID!
           try userRef
                .document(eigeneID)
                .setData(from: product)
        } catch {
            print(error)
        }
    }
    
    func oldOrderSnapshotListener(compleation: @escaping ([Product], Error?) -> Void) {
        guard let uid = currentUser?.uid else {
            compleation([], nil)
            return
        }
        
        let userRef = store.collection("users").document(uid).collection("Old-Orders")
        userRef
            .addSnapshotListener(includeMetadataChanges: false) { snapshot, error in
                if let error = error {
                    print("Error listening for changes: \(error)")
                    compleation([], error)
                    return
                }
                guard let snapshot else {
                    fatalError("snapshot ist leer")
                }
                let oldOrder = snapshot
                    .documents
                    .compactMap { oldOrder in
                        try? oldOrder.data(as: Product.self)
                    }
                compleation(oldOrder, nil)
            }
    }
    
    
    //MARK: Notification
    
    func checkCartAndScheduleNotification() {
        guard let uid = currentUser?.uid else {
            return
        }
        
        store
            .collection("users").document(uid).collection("Cart").getDocuments { (snapshot, error) in
                if let error = error {
                    print("Fehler beim Abrufen des Warenkorbs: \(error)")
                    return
                }
                
                guard let documents = snapshot?.documents, !documents.isEmpty else {
                        print("Warenkorb ist leer")
                        // Alte Benachrichtigung entfernen, wenn der Warenkorb leer ist
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["cartReminder"]) // Dies ist sinnvoll, um eine neue Benachrichtigung zu planen und keine doppelten oder veralteten Benachrichtigungen anzuzeigen.
                        return
                    }
                    // Alte Benachrichtigung entfernen, um sie neu zu planen
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["cartReminder"])
                    
                    // Wenn Produkte im Warenkorb sind, plane eine wiederholende Benachrichtigung
                    self.scheduleCartNotification()
            }
        }
        
        private func scheduleCartNotification() {
            let content = UNMutableNotificationContent()
            content.title = "Produkte im Warenkorb!"
            content.body = "Du hast noch Produkte im Warenkorb. Schließe deine Bestellung ab!"
            content.sound = UNNotificationSound.default
            content.userInfo = ["targetView": "CartView"] // Ziel-View definieren, zum Navigieren beim drauf tippen

            // Action hinzufügen
               let showCartAction = UNNotificationAction(
                   identifier: "SHOW_CART_ACTION",
                   title: "Zum Warenkorb",
                   options: [.foreground]
               )
               let category = UNNotificationCategory(
                   identifier: "CART_REMINDER",
                   actions: [showCartAction],
                   intentIdentifiers: [],
                   options: []
               )
               UNUserNotificationCenter.current().setNotificationCategories([category])
               content.categoryIdentifier = "CART_REMINDER"
            
            // Zeitpunkt für die Benachrichtigung (z. B. in 1 Minute(timeInterval: 60) )
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
            let request = UNNotificationRequest(identifier: "cartReminder", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Fehler beim Planen der Benachrichtigung: \(error)")
                }
            }
        }
    // MARK: - Notification Helper
    private func createNotificationAttachment() -> UNNotificationAttachment? {
        guard let imageURL = Bundle.main.url(forResource: "cartIcon", withExtension: "png") else {
            print("Bild nicht gefunden")
            return nil
        }
        
        do {
            let attachment = try UNNotificationAttachment(identifier: "cartIcon", url: imageURL, options: nil)
            return attachment
        } catch {
            print("Fehler beim Laden des Bildes: \(error)")
            return nil
        }
    }
}
