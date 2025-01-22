//
//  HomeView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 15.01.25.
//

import SwiftUI

struct HomeView: View {
    
    @State var products: [Product]?
    @State var isLoading: Bool = false
    @State var search = ""
    let randomList = ["text1", "text2", "text3", "text4", "text5"]

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
              
                ScrollView {
                    VStack {
                        Text("Ihre Lieblingsmarken \n in einer App!")
                            .font(.title)
                            .fontDesign(.serif)
                            .frame(height: 100)
                    }
                    .padding(.vertical,20)
                    .opacity(0.0)
                    VStack {
                        Text("TOP BRANDS")
                            .fontDesign(.default)
                            .font(.title3)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(products ?? []) { item in
                                VStack {
                                    AsyncImage(url: URL(string: item.images[0])) { pic in
                                         pic
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .frame(width: 150, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))

                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                        }  .onAppear {
                                Task {
                                    try await getProducts()
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
                        ForEach(products ?? []) { item in
                            ZStack {
    //                            Image("ring")
    //                                .resizable()
    //                                .scaledToFit()
    //                                .padding()
    //                                .opacity(0.9)
                                
                                AsyncImage(url: URL(string: item.images[0])) { pic in
                                     pic
                                    .resizable()
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
    //                                .opacity(0.9)

                                } placeholder: {
                                    ProgressView()
                                }
                                Text("Nie aus der Mode")
                                    .font(.title3)
                                    .fontDesign(.monospaced)
                                    .foregroundColor(.black)
                                    .padding()
                                    .offset(y: 140)
                                Text(item.category.name)
                                    .font(.largeTitle)
                                    .fontDesign(.serif)
                                    .foregroundColor(.black)
                                    .padding()
                                    .offset(y: 180)
                                    .italic()
                            }
                            .background(Color.gray.opacity(0.1))
                            
                        }
                        .listStyle(.inset)
                        .scrollTransition(.interactive, axis: .vertical) { view, phase in
                            view.scaleEffect(phase.value < 1 ? 1 : 0)
                                .offset(y: phase.value * -100)
                                .blur(radius: phase.value * 4)
                        }
    //                    .scrollTargetLayout()
                    }
                    .padding()
                    .navigationTitle("Fast Shop")
                    .navigationBarTitleDisplayMode(.inline)
    //                .searchable(text: $search, placement: .navigationBarDrawer(displayMode:.always), prompt: "Suche...")
                }
                VStack {
                    Text("Ihre Lieblingsmarken \n in einer App!")
                        .font(.title)
                        .fontDesign(.serif)
                        .frame(height: 100)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.thinMaterial)
    //            .scrollTargetBehavior(.paging)
            }
        }
    }
      
    
    
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products") else {
            throw errorEnum.invalidURL
        }
       
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            products = try JSONDecoder().decode([Product].self, from: data)
        } catch {
            print(error)
        }
        return []
    }
}
#Preview {
    HomeView()
}
