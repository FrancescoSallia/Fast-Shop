//
//  HomeView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 15.01.25.
//

import SwiftUI

struct HomeView: View {
    
    @State var selected = ""
    
    var body: some View {
        VStack {
            
            HStack(alignment: .firstTextBaseline){
                Text("Willkommen, Username")
                    .bold()
                Spacer()
            }
            .padding(.horizontal)
            Divider()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(1...6, id: \.self) { test in
                        Text("Kategorie \(test)")
                            .padding()
                            .bold()
                            .underline()
                    }
                }
                .fixedSize(horizontal: true, vertical: true)
            }
            
            ScrollView {
                ForEach(0...10, id: \.self) { option in
                    VStack {
                        HStack {
                            Spacer()
                            VStack {
                                Image("tshirt")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 130)
                                    .clipShape(.rect(cornerRadius: 15))
                                Text("Hier kommt Beschreibung")
                                Text("22,50€")
                            }
                            Spacer()
                            Spacer()
                            VStack {
                                Image("ring")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 130)
                                    .clipShape(.rect(cornerRadius: 15))
                                Text("Hier kommt Beschreibung")
                                Text("102,90€")
                            }
                            Spacer()
                        }
                    }
                    .padding()
                }
//                .background(Color.orange.opacity(0.1))
//                .padding(.horizontal)
            }
            
            Text("Hier kommen weitere artikeln etc.")
                
            
           
        }
    }
}
#Preview {
    HomeView()
}
