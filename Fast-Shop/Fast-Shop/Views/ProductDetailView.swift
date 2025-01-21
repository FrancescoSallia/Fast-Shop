//
//  ProductDetailView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 21.01.25.
//

import SwiftUI

struct ProductDetailView: View {
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                TabView {
                    Image("pants")
                        .resizable()
                        .frame(width: .infinity, height: 600)
                    Image("pants")
                        .resizable()
                        .frame(width: .infinity, height: 600)
                    Image("pants")
                        .resizable()
                        .frame(width: .infinity, height: 600)
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(width: 400, height: 600)
                
                
                VStack(alignment: .leading) {
                    Text("SIKSILK")
                    Text("GRAPHIC - Pants print - red")
                        .bold()
                    HStack {
                        Text("ab 27,91€")
                            .bold()
                            .padding(.bottom, 6)
                        Text("inkl.MwSt.")
                            .foregroundStyle(.gray)
                    }
                    Text("Letzter niedrigster Preis 25,77€")
                    Text("Ursprünglich 42,95€")
                    
                    HStack {
                        Text("Farbe:")
                        Text("Black")
                            .bold()
                    }
                    
                }
                .padding(.horizontal)
            }
        }
        
        
        
    }
}
#Preview {
    ProductDetailView()
}
