//
//  CardView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 28.01.25.
//

import SwiftUI

struct CardView: View {
    let productsFromCard: [Product]
    @State var counter = 1
    @State var disableCounter: Bool = false
    var body: some View {
        
        HStack {
            Text("EINKAUFSKORB(2)")
                .font(.footnote)
                .frame(height: 4)
                .padding()
                .padding(.horizontal,35)
                .border(.black)
                .padding(.leading,-20)
            HStack {
                Text("FAVORITEN")
                Image(systemName: "bookmark")
            }
            .font(.footnote)
            .frame(height: 4)
            .padding()
            .padding(.horizontal,37)
            .border(.black)
            .padding(-10)
        }
        
        ScrollView {
           
            
            ZStack {
                    HStack {
                        Image("pants")
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .padding(.trailing, -8)
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                }
                
                VStack {
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "bookmark")
                        }
                        .tint(.black)
                        Button {
                            
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .tint(.black)
                    }
                    .padding()
                    .offset(x:160, y: -90)
                    
                    Group {
                        Text("Titel vom produkt")
                        Text("Preis vom Produkt")
                    }
                    .font(.footnote)
                    .offset(x: 70, y: -70)
                }
                HStack(spacing: 30) {
                    Button("-"){
                        if counter <= 0 {
                            disableCounter = true
                        } else {
                            disableCounter = false
                            $counter.wrappedValue -= 1
                        }
                    }
                    .disabled(disableCounter)
                    Text("\(counter)")
                    Button("+"){
                        disableCounter = false
                        $counter.wrappedValue += 1
                        print(counter)

                    }
                }
                .tint(.black)
                .padding()
                .border(.black)
                .font(.headline)
                .offset(x: 80, y: 115)

                
            }
            .border(.black)
            ZStack {
                    HStack {
                        Image("pants")
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .padding(.trailing, -8)
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                }
                
                VStack {
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "bookmark")
                        }
                        .tint(.black)
                        Button {
                            
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .tint(.black)
                    }
                    .padding()
                    .offset(x:160, y: -90)
                    
                    Group {
                        Text("Titel vom produkt")
                        Text("Preis vom Produkt")
                    }
                    .font(.footnote)
                    .offset(x: 70, y: -70)
                }
                HStack(spacing: 30) {
                    Button("-"){
                        if counter <= 0 {
                            disableCounter = true
                        } else {
                            disableCounter = false
                            $counter.wrappedValue -= 1
                        }
                    }
                    .disabled(disableCounter)
                    Text("\(counter)")
                    Button("+"){
                        disableCounter = false
                        $counter.wrappedValue += 1
                        print(counter)

                    }
                }
                .tint(.black)
                .padding()
                .border(.black)
                .font(.headline)
                .offset(x: 80, y: 115)

                
            }
            .border(.black)
            ZStack {
                    HStack {
                        Image("pants")
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .padding(.trailing, -8)
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                }
                
                VStack {
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "bookmark")
                        }
                        .tint(.black)
                        Button {
                            
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .tint(.black)
                    }
                    .padding()
                    .offset(x:160, y: -90)
                    
                    Group {
                        Text("Titel vom produkt")
                        Text("Preis vom Produkt")
                    }
                    .font(.footnote)
                    .offset(x: 70, y: -70)
                }
                HStack(spacing: 30) {
                    Button("-"){
                        if counter <= 0 {
                            disableCounter = true
                        } else {
                            disableCounter = false
                            $counter.wrappedValue -= 1
                        }
                    }
                    .disabled(disableCounter)
                    Text("\(counter)")
                    Button("+"){
                        disableCounter = false
                        $counter.wrappedValue += 1
                        print(counter)

                    }
                }
                .tint(.black)
                .padding()
                .border(.black)
                .font(.headline)
                .offset(x: 80, y: 115)

                
            }
            .border(.black)
        }
        .padding(.bottom, -10)
        HStack {
            Text("GESAMT")
                .font(.footnote)
            Spacer()
            VStack {
                Text("49,95 €")
                Text("INKL. MWST.")
            }
            .font(.footnote)
        }
        .padding(.horizontal)
        .padding()
        .border(.black)
        .padding(.bottom,-8)
        HStack(alignment:.bottom) {
            Button("WEITER") {
                //
            }
            .padding()
            .frame(maxWidth: .infinity)
            .border(.black)
        }
    }
}

#Preview {
    CardView(productsFromCard: ProductViewModel().products)
}
