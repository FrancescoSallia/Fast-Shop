//
//  AdressView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 05.02.25.
//

import SwiftUI

struct AdressView: View {
    
    @ObservedObject var viewModel: AdressViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: 405, maxHeight: 96)
                .foregroundStyle(.white)
                .border(.black)
            HStack {
                Image(systemName: "house.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                Text("Wunschadresse")
            }
        }
        ScrollView {
            VStack {
//                HStack {
//                    Image(systemName: "largecircle.fill.circle")
//                        .padding(.trailing, 8)
//                    VStack (alignment: .leading) {
//                        HStack {
//                            Text(viewModel.user.adress?.firstName ?? "NO NAME")
//                            Text(viewModel.user.adress?.secondName ?? "No Second Name")
//                        }
//                        HStack {
//                            Text(viewModel.user.adress?.street ?? "NO STREET")
//                            Text(viewModel.user.adress?.houseNumber ?? "NO HOUSENUMBER")
//                        }
//                        HStack {
//                            Text("\(viewModel.user.adress?.plz ?? "NO PLZ"),")
//                            Text(viewModel.user.adress?.location ?? "NO LOCATION")
//                        }
//                    }
//                }
                HStack {
                    Button {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            viewModel.showTextFields.toggle()
                        }
                    } label: {
                        if !viewModel.showTextFields{
                            Image(systemName: "plus")
                                .padding(.trailing, 8)
                            Text("Neue Adresse hinzufügen")
                        }
                        
                    }
                    .tint(.primary)
                    
                }
                .padding()
                
                if viewModel.showTextFields {
                    VStack {
                        TextField("Vorname", text: .constant(""))
                            .padding()
                            .textFieldStyle(.plain)
                            .border(.primary.opacity(0.4))
                        
                        TextField("Nachname", text: .constant(""))
                            .padding()
                            .textFieldStyle(.plain)
                            .border(.primary.opacity(0.4))
                        
                        TextField("Adresse", text: .constant(""))
                            .padding()
                            .textFieldStyle(.plain)
                            .border(.primary.opacity(0.4))
                        
                        TextField("Hausnummer", text: .constant(""))
                            .padding()
                            .textFieldStyle(.plain)
                            .border(.primary.opacity(0.4))
                        
                        TextField("PLZ", text: .constant(""))
                            .padding()
                            .textFieldStyle(.plain)
                            .border(.primary.opacity(0.4))
                        
                        TextField("Ort", text: .constant(""))
                            .padding()
                            .textFieldStyle(.plain)
                            .border(.primary.opacity(0.4))
                        
                        VStack {
                            Button("Stornieren") {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    viewModel.showTextFields.toggle()
                                }
                            }
                            .frame(maxWidth: 400, minHeight: 50)
                            .border(.primary)
                            .foregroundStyle(.primary)
                            
                            Button("Speichern") {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    viewModel.showTextFields.toggle()
                                }
                            }
                            .frame(maxWidth: 400, minHeight: 50)
                            .foregroundStyle(.white)
                            .background(Color.primary)
                        }
                        .padding(.top, 30)
                    }
                    .padding()
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    AdressView(viewModel: AdressViewModel())
}
