//
//  HomeView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 15.01.25.
//

import SwiftUI

struct HomeView: View {
    
    @State var products: [Product] = []
    @StateObject var viewModel = ProductViewModel()
    @State var isLoading: Bool = false
//    @State var search = ""
    @State var scrollPosition = ScrollPosition()
    @State var categorieText: String = ""
    let randomList = ["text1", "text2", "text3", "text4", "text5"]

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ScrollView {
//                    VStack {
//                        Text("\(categorieText)")//Ihre Lieblingsmarken \n in einer App!
//                            .font(.title)
//                            .fontDesign(.serif)
//                            .frame(height:100)
//                    }
//                    .padding(.vertical,20)
//                    .opacity(0.0)
                    
                    VStack {
                        ForEach(products) { item in
                            ZStack {
                                
                                AsyncImage(url: URL(string: item.images[0])) { pic in
                                     pic
                                    .resizable()
                                    .frame(width: 400, height: 690)
                                    .onScrollVisibilityChange { isVisible in
                                        if isVisible {
                                            categorieText = item.category.name
                                        }
                                    }
//                                    .scaledToFit()
//                                    .frame(width: .infinity)
//                                    .padding()
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
                            
                        }
                        .listStyle(.inset)
                        .scrollTransition(.interactive, axis: .vertical) { view, phase in
                            view.scaleEffect(phase.value < 1 ? 1.1 : 0)
                                .offset(y: phase.value * -80)
//                                .blur(radius: phase.value * 4)
//                            view.brightness(phase.value < 1 ? 0 : 1)
//                            .offset(y: phase.value * -50)

                        }
    //                    .scrollTargetLayout()
                    }
                    .padding()
//                    .navigationTitle("Fast Shop")
                    .navigationBarTitleDisplayMode(.inline)
                    .ignoresSafeArea()

    //                .searchable(text: $search, placement: .navigationBarDrawer(displayMode:.always), prompt: "Suche...")
                }
                VStack {
                    Text("\(categorieText)")//Ihre Lieblingsmarken \n in einer App!
                        .font(.title)
                        .fontDesign(.serif)
                        .frame(height: 80)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.thinMaterial)
    //            .scrollTargetBehavior(.paging)
            }

        }
        .onAppear {
            Task {
//                try await viewModel.getProductsFromAPI()
                try await getProducts()
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
