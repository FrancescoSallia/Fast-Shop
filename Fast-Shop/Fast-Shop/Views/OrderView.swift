//
//  OrderSheetView.swiftColor("AccentColor")
//  Fast-Shop
//
//  Created by Francesco Sallia on 01.02.25.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var viewModel: ProductViewModel
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        ForEach(0...1, id: \.self) { item in
                            ZStack {
                                Rectangle()
                                    .frame(width: 206, height: 100)
                                    .foregroundStyle(.white)
                                    .border(Color.black)
                                    .padding(-4)
                                VStack {
                                    Image(systemName: "map.fill")
                                    Text("Lieferstelle")
                                }
                            }
                        }
                    }
                    
                    ZStack {
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .foregroundStyle(.white)
                            .border(Color.primary)
                            .padding(-6)
                        HStack {
                            Text("Musterstraße 123") //Als NavigationLink
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    
                    HStack {
                        Text("ZUSTELLUNG")
                            .font(.footnote)
                            .padding()
                        Spacer()
                    }
                    ScrollView(.horizontal) {
                        HStack(alignment: .firstTextBaseline) {
                            ForEach(viewModel.user.cart, id: \.cartID) { cartItem in
                                AsyncImage(url: URL(string: cartItem.images[0])) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .frame(maxWidth: 122, maxHeight: 150)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .padding(.leading, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    VStack {
                        HStack {
                            Image(systemName: viewModel.selectedDeliveryOption == 0 ? "largecircle.fill.circle" : "circle")
                                .frame(width: 16)
                                .onTapGesture {
                                    viewModel.selectedDeliveryOption = 0
                                    viewModel.selectedDeliveryPrice = "KOSTENLOS"
                                }

                            Text("\(viewModel.deliveryDate(daysToAdd: 3)) - \(viewModel.deliveryDate(daysToAdd: 4))")
                                .font(.footnote)
                            Spacer()
                            Text("KOSTENLOS")
                                .font(.footnote)
                        }
                        .padding(.top)
                        .padding(.horizontal)

                        HStack {
                            Image(systemName: viewModel.selectedDeliveryOption == 1 ? "largecircle.fill.circle" : "circle")
                                .frame(width: 16)
                                .onTapGesture {
                                    viewModel.selectedDeliveryOption = 1
                                    viewModel.selectedDeliveryPrice = "8.95"
                                }

                            Text("\(viewModel.deliveryDate(daysToAdd: 2)) - \(viewModel.deliveryDate(daysToAdd: 3))")
                                .font(.footnote)
                            Spacer()
                            Text("8,95 €")
                                .font(.footnote)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            VStack {
                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(.white)
                        .border(Color.black)
                    HStack {
                        Text("VERSAND")
                            .font(.footnote)
                        Spacer()
                        Text(viewModel.selectedDeliveryOption == 1 ? "8,95 €" : "KOSTENLOS")
                            .font(.footnote)
                    }
                    .padding(.horizontal)
                    .bold()
                }
                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(.black)
                    NavigationLink("WEITER", destination: {
                        PayOptionView(viewModel: viewModel)
                    })
                    .tint(.white)
                }
                .padding(.top ,-8)
            }
        }
    }

}

#Preview {
    OrderView(viewModel: ProductViewModel())
}
