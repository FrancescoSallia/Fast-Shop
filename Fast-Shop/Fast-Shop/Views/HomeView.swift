//
//  HomeView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 15.01.25.
//

import SwiftUI

struct HomeView: View {
    
    @State var search = ""
    var randomList = ["text1", "text2", "text3", "text4", "text5"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    //            Text("Fast Shop")
                    //                .fontDesign(.monospaced)
                    //                .padding()
                
                    Text("Ihre Lieblingsmarken \n in einer App!")
                        .font(.title)
                        .fontDesign(.serif)
                        .frame(height: 100)
                }
        
                
                VStack {
                    Text("TOP BRANDS")
                        .fontDesign(.default)
                        .font(.title3)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(randomList, id: \.self) { item in
                            VStack {
                                Image("tshirt")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(.circle)
                                    .frame(width: 100, height: 100)
                                    .shadow(radius: 2, x: 2, y: 2)

                                Text("Title")
                                    .fontDesign(.serif)
                                    .font(.footnote)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                TabView {
                    Image("tasche")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    Image("ring")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    Image("tshirt")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(width: 400, height: 300)
                .padding()

                VStack {
                    ForEach(randomList, id: \.self) { item in
                        Image("ring")
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                    .listStyle(.inset)
                    
                }
                .padding()
                .navigationTitle("Fast Shop")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $search, prompt: "Suche...")
            }
        }
    }
}
#Preview {
    HomeView()
}
