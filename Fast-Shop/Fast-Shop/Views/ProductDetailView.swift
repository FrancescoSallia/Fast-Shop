//
//  ProductDetailView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 21.01.25.
//

import SwiftUI

struct ProductDetailView: View {

    var body: some View {
        NavigationStack {
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
                        
                        HStack() {
                            Button("HINZUFÜGEN") {
                                //
                            }
                            .frame(width: 280, height: 45)
                            .border(Color.gray)
                            .tint(.white)
                            .background(Color.primary)
                            
                            Button {
                                //
                            } label: {
                                Image(systemName: "bookmark")
                            }
                            .frame(width: 55, height: 45)
                            .border(Color.gray)
                            .tint(.white)
                            .background(Color.primary)
                            .padding(.leading, 12)
                        }
                        
                        Text("(BESCHREIBUNG) Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.")
                            .padding()
                    }
                    .padding(.horizontal)
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //
                    } label:{
                        Image(systemName: "square.and.arrow.up")
                    }
                    .foregroundStyle(.primary)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    ZStack {
                        Button {
                            //
                        } label:{
                            Image(systemName: "bag")
                        }
                        .foregroundStyle(.primary)

                        Text("2")
                            .font(.footnote)
                            .offset(x: 3, y: 1)
                            .foregroundStyle(.primary)
                    }
                }
            })
        }
    }
}
#Preview {
    ProductDetailView()
}
