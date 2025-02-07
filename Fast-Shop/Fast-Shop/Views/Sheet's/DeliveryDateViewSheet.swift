//
//  OrderSheetView.swiftColor("AccentColor")
//  Fast-Shop
//
//  Created by Francesco Sallia on 01.02.25.
//

import SwiftUI

struct DeliveryDateViewSheet: View {
    @ObservedObject var viewModel: ProductViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .frame(maxWidth: 405, maxHeight: 96)
                    .foregroundStyle(.white)
                    .border(.black)
                HStack {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text("Erwartete Zustellung")
                }
                .padding()
            }
            ScrollView {
                VStack {
                    HStack {
                        Image(systemName: viewModel.selectedDeliveryOption == 0 ? "largecircle.fill.circle" : "circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .onTapGesture {
                                viewModel.selectedDeliveryOption = 0
                                viewModel.selectedDeliveryPrice = "KOSTENLOS"
                                viewModel.showOrderViewSheet = false
                            }

                        Text("\(viewModel.deliveryDate(daysToAdd: 4)) - \(viewModel.deliveryDate(daysToAdd: 6))")
//                            .font(.footnote)
                        Spacer()
                        Text("KOSTENLOS")
                            .font(.callout)
                    }
                    .padding(.top)
                    .padding(.horizontal)

                    HStack {
                        Image(systemName: viewModel.selectedDeliveryOption == 1 ? "largecircle.fill.circle" : "circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .onTapGesture {
                                viewModel.selectedDeliveryOption = 1
                                viewModel.selectedDeliveryPrice = "8.95"
                                viewModel.showOrderViewSheet = false

                            }

                        Text("\(viewModel.deliveryDate(daysToAdd: 1)) - \(viewModel.deliveryDate(daysToAdd: 3))")
//                            .font(.footnote)
                        Spacer()
                        Text("+8,95 €")
                            .font(.callout)
                    }
                    .padding()
                }
                .padding()
//                VStack {
//                    ScrollView(.horizontal) {
//                        HStack(alignment: .firstTextBaseline) {
//                            ForEach(viewModel.user.cart, id: \.cartID) { cartItem in
//                                AsyncImage(url: URL(string: cartItem.images[0])) { image in
//                                    image
//                                        .resizable()
//                                        .aspectRatio(1.0, contentMode: .fit)
//                                        .frame(maxWidth: 122, maxHeight: 150)
//                                } placeholder: {
//                                    ProgressView()
//                                }
//                            }
//                        }
//                        .padding(.leading, 4)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                    
//                }
            }
        }
    }

}

#Preview {
    DeliveryDateViewSheet(viewModel: ProductViewModel())
}
