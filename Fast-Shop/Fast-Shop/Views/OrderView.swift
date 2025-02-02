//
//  OrderSheetView.swiftColor("AccentColor")
//  Fast-Shop
//
//  Created by Francesco Sallia on 01.02.25.
//

import SwiftUI

struct OrderView: View {
    var body: some View {
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
                        .frame(width: .infinity, height: 60)
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
                HStack {
                    Image("ring")
                        .resizable()
                        .frame(width:110, height: 140)
                    Image("ring")
                        .resizable()
                        .frame(width:110, height: 140)
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        Image(systemName: "button.programmable")
                        Text("DIENSTAG 04, FEBRUAR - MITTWOCH 05, FEBRUAR")
                            .font(.footnote)
                        Spacer()
                        Text("KOSTENLOS")
                            .font(.footnote)
                        
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    HStack {
//                        Image(systemName: "button.programmable")
                        Circle()
                            .stroke(lineWidth: 1)
                            .frame(width: 16)
                        Text("MONTAG 03, FEBRUAR - DIENSTAG 04, FEBRUAR")
                            .font(.footnote)
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
                    .frame(width: .infinity, height: 50)
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
                    .frame(width: .infinity, height: 50)
                    .foregroundStyle(.black)
                        Button("WEITER") {
                            //
                        }
                        .tint(.white)
            }
            .padding(-8)
        }
    }
}

#Preview {
    OrderView()
}
