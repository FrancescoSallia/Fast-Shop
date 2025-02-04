//
//  OrderSheetView.swiftColor("AccentColor")
//  Fast-Shop
//
//  Created by Francesco Sallia on 01.02.25.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var viewModel: ProductViewModel
    @State var deliveryIsSelected = false
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
                                //                            Image("pants")
                                //                             .resizable()
                                //                             .aspectRatio(1.0, contentMode: .fill)
                                //                             .frame(maxWidth: 140, maxHeight: 150)
                            }
                        }
                        .padding(.leading, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack {
                        HStack {
                            if !deliveryIsSelected {
                                Image(systemName: "button.programmable")
                                    .frame(width: 16)
                                    .onTapGesture {
                                        deliveryIsSelected.toggle()
                                    }
                            } else {
                                Circle()
                                    .stroke(lineWidth: 1)
                                    .frame(width: 16)
                                    .onTapGesture {
                                        deliveryIsSelected.toggle()
                                    }
                            }
                            Text("\(getEstimatedDeliveryDateSkippingWeekends(daysToAdd: 5)) - \(getEstimatedDeliveryDateSkippingWeekends(daysToAdd: 7))")
                                .font(.footnote)
                            Spacer()
                            Text("KOSTENLOS")
                                .font(.footnote)
                            
                            Spacer()
                        }
                        .padding(.top)
                        .padding(.horizontal)
                        HStack {
                            if deliveryIsSelected {
                                Image(systemName: "button.programmable")
                                    .frame(width: 16)
                                    .onTapGesture {
                                        deliveryIsSelected.toggle()
                                    }
                            } else {
                                Circle()
                                    .stroke(lineWidth: 1)
                                    .frame(width: 16)
                                    .onTapGesture {
                                        deliveryIsSelected.toggle()
                                    }
                            }
                            
                            Text("\(getEstimatedDeliveryDateSkippingWeekends(daysToAdd: 3)) - \(getEstimatedDeliveryDateSkippingWeekends(daysToAdd: 4))")                                .font(.footnote)
                            Spacer()
                            Text("8,95 EUR")
                                .font(.footnote)
                            Spacer()
                            
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
                        Text("KOSTENLOS")
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
    func getEstimatedDeliveryDateSkippingWeekends(daysToAdd: Int) -> String {
        let calendar = Calendar.current
        var date = Date()
        var addedDays = 0

        while addedDays < daysToAdd {
            date = calendar.date(byAdding: .day, value: 1, to: date)! // Einen Tag hinzufügen

            let weekday = calendar.component(.weekday, from: date)
            if weekday != 1 && weekday != 7 { // 1 = Sonntag, 7 = Samstag (keine Lieferung)
                addedDays += 1
            }
        }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE") // Deutsches Format
        dateFormatter.dateFormat = "EEEE, d. MMMM" // Beispiel: "Freitag, 9. Februar"

        return dateFormatter.string(from: date)
    }
}

#Preview {
    OrderView(viewModel: ProductViewModel())
}
