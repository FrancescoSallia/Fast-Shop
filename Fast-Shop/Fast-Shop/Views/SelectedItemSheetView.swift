//
//  SelectedItemSheetView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 25.01.25.
//

import SwiftUI

struct SelectedItemSheetView: View {
    
    let sizes: [String] = ["S", "M", "L", "XL", "XXL"]
    var body: some View {
        Text("Title vom produkt")
        Text("Preis vom produkt")
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<5) { _ in
                    Rectangle()
                        .frame(width: 110, height: 180)
                        .foregroundStyle(.red)
                }
            }
        }
        .padding(.leading)
        
        Text("Wählen Sie eine Größe aus")
        
        ForEach(sizes, id: \.self) { item in
            HStack {
                ZStack {
                    Rectangle()
                        .frame(width: 210, height: 80)
                        .border(.black, width: 2)
                        .foregroundStyle(.white)
                        .offset(x:10)
                    Text(item)
                    
                }
                ZStack {
                    Rectangle()
                        .frame(width: 210, height: 80)
                        .border(.black, width: 2)
                        .foregroundStyle(.white)
                    Text(item)
                    
                }
            }
        }
            
    }
}

#Preview {
    SelectedItemSheetView()
}
