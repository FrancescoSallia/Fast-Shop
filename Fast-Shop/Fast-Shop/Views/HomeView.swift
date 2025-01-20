//
//  HomeView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 15.01.25.
//

import SwiftUI

struct HomeView: View {
    
    @State var search = ""
    let randomList = ["text1", "text2", "text3", "text4", "text5"]

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
                .padding(.vertical,20)
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
                        ZStack {
                            Image("ring")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .opacity(0.9)
                            
                            Text("Nie aus der Mode")
                                .font(.title3)
                                .fontDesign(.monospaced)
                                .foregroundColor(.black)
                                .padding()
                                .offset(y: 140)
                            Text("Ringe")
                                .font(.largeTitle)
                                .fontDesign(.serif)
                                .foregroundColor(.black)
                                .padding()
                                .offset(y: 180)
                                .italic()
//                            Image(systemName: "heart")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 40, height: 40)
//                                .foregroundStyle(.red)
//                                .offset(x: 150, y: 190)
                        }
                        .background(Color.red.opacity(0.1))
                        
                    }
                    .listStyle(.inset)
                    .scrollTransition(.interactive, axis: .vertical) { view, phase in
                        view.scaleEffect(phase.value < 1 ? 1 : 0)
//                            .offset(y: phase.value * -100)
//                            .rotationEffect(phase.value.rounded(.down) == 0 ? Angle(degrees: 0) : Angle(degrees: 360))
                    }
//                    .scrollTargetLayout()
                }
                .padding()
                .navigationTitle("Fast Shop")
                .navigationBarTitleDisplayMode(.inline)
//                .searchable(text: $search, placement: .navigationBarDrawer(displayMode:.always), prompt: "Suche...")
            }
//            .scrollTargetBehavior(.paging)
        }
    }
}
#Preview {
    HomeView()
}
