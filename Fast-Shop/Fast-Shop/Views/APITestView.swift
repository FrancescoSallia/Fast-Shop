//
//  APITestView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 20.01.25.
//

import SwiftUI

struct APITestView: View {
    @StateObject var user = User(name: "John")
    var product = Product(id: 1, title: "TEST Product", price: 22.50, description: "Ein test produkt von mir erstellt mit beschreibung", images: ["tshirt"], category: Category(id: 1, name: "Categorie test", image: "ring", creationAt: "gestern erstellt", updatedAt: "jetzt up to date"))

    var body: some View {
        
        VStack {
            Text("User: \(user.name)")
            // Um die Favoriten zu sehen, wechsel von user.card zu user.favorite
            List(user.cart) { product in
                
                Text("gekaufter produkt: \(product.title)")
                Text("favorisiertes produkt: \(product)")

            }
            .frame(height: 200)
            Button("ADD TO CARD") {
                user.cart.append(product)

            }
            
            Button("Delete first Product from Card") {
                user.cart.remove(at: 0)
//                user.warenkorb.removeAll(where: { $0.id == product.id }) //   LÖSCHT ALLE PRODUKTE MIT DER SELBEN ID
            }
            
            Button("Add to Favorite") {
                user.favorite.append(product)
                print("added to favorite: \(user.favorite)")
            }
        }
  }
   
}
#Preview {
    APITestView()
}



