//
//  HomeView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 15.01.25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = ProductViewModel()
//    @State var isLoading: Bool = false
    @Binding var isScrolling: Bool
//    @State var scrollPosition = ScrollPosition()
    @State var categorieText: String = ""

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ScrollView {
                    VStack {
                        ForEach(viewModel.products) { item in
                            ZStack {
                                AsyncImage(url: URL(string: item.images[0])) { pic in
                                     pic
                                    .resizable()
                                    .frame(width: 400, height: 700)
                                    .onScrollVisibilityChange { isVisible in
                                        if isVisible {
                                            categorieText = item.category.name
                                            
                                        }
                                    }
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
//                        .listStyle(.inset)
//                        .scrollTransition(.interactive, axis: .vertical) { view, phase in
////                            view.offset(y: phase.value * -70)
//                        }
                    }
                    .padding()
                    .navigationBarTitleDisplayMode(.inline)
                    .ignoresSafeArea()
                }
                .onScrollGeometryChange(for: CGFloat.self, of: { geometry in
                    geometry.contentOffset.y
                }, action: { oldValue, newValue in
                    if newValue > oldValue {
                        withAnimation {
                            isScrolling = false
                        }
                    }
                    else {
                        withAnimation {
                            isScrolling = true
                        }
                    }
                })
                HStack(alignment: .firstTextBaseline) {
                    Text("\(categorieText)")//Ihre Lieblingsmarken \n in einer App!
                        .font(.largeTitle)
                        .fontDesign(.serif)
                        .frame(height: 90)
                        .padding(.horizontal,50)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
            }
        }
        .onAppear {
            Task {
                try await viewModel.getProductsFromAPI()
            }
        }
    }
}
#Preview {
    HomeView(isScrolling: .constant(true))
}
