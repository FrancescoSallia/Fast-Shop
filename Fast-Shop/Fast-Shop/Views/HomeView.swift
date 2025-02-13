//
//  HomeView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 15.01.25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = ProductViewModel()
    @ObservedObject var errorHandler: ErrorHandler = .shared

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
                                            viewModel.categorieText = item.category.name
                                            
                                        }
                                    }
                                } placeholder: {
                                    ProgressView()
                                }
                                Text("FAST-SHOP")
                                    .font(.title)
                                    .fontDesign(.monospaced)
                                    .foregroundColor(.black)
                                    .padding()
                                    .offset(y: 140)
                                    .frame(maxWidth: 350, maxHeight: 100)
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
//                            view.scaleEffect(CGFloat(1 + phase.value * 0.2))
//                        }
                    }
                    .padding()
                    .navigationBarTitleDisplayMode(.inline)
                    .ignoresSafeArea()
                }
                HStack(alignment: .firstTextBaseline) {
                    Text("\(viewModel.categorieText)")//Ihre Lieblingsmarken \n in einer App!
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
              viewModel.getProductsFromAPI()
        }
        .alert(isPresented: $errorHandler.showError) {
            Alert(
                title: Text("Error"),
                message: Text(errorHandler.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
#Preview {
    HomeView()
}
