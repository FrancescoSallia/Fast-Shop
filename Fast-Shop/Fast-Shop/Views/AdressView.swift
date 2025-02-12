//
//  AdressView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 05.02.25.
//

import SwiftUI

struct AdressView: View {
    
    @ObservedObject var viewModel: AdressViewModel
    @ObservedObject var viewModelFirestore: FirestoreViewModel
    
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
//        ScrollView {
            VStack(alignment: .leading) {
                List(viewModelFirestore.adressList, id: \.adressID) { adress in
//                List(viewModel.testAdressArray, id: \.adressID) { adress in
                HStack {
                    Image(systemName: viewModel.selectedAdressOption == adress.adressID ? "largecircle.fill.circle" : "circle")
                        .padding(.trailing, 8)
                        .onTapGesture {
                            
                            withAnimation(.easeInOut(duration: 0.25)) {
                                viewModel.selectedAdressOption = adress.adressID
                            }
                        }
                    VStack (alignment: .leading) {
                        HStack {
                            Text("\(adress.firstName)")
                            Text(adress.secondName)
                        }
                        HStack {
                            Text(adress.street)
                            Text(adress.houseNumber)
                        }
                        HStack {
                            Text(adress.plz)
                            Text(adress.location)
                        }
                    }
                }
                .swipeActions(allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        viewModelFirestore.deleteUserAdress(adress: adress)
                    } label: {
                        Image(systemName: "trash")
                    }


                }
            }
             .listStyle(.plain)
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
                .padding(.leading, 55)

                if viewModel.showTextFields {
                    VStack {
                        TextField("Vorname", text: $viewModel.firstName)
                            .padding()
                            .textFieldStyle(.plain)
                            .border(.primary.opacity(0.4))
                        
                        TextField("Nachname", text: $viewModel.secondName)
                            .padding()
                            .textFieldStyle(.plain)
                            .border(.primary.opacity(0.4))
                        
                        TextField("Adresse", text: $viewModel.street)
                            .padding()
                            .textFieldStyle(.plain)
                            .border(.primary.opacity(0.4))
                        
                        TextField("Hausnummer", text: $viewModel.houseNumber)
                            .padding()
                            .textFieldStyle(.plain)
                            .border(.primary.opacity(0.4))
                        
                        TextField("PLZ", text: $viewModel.plz)
                            .padding()
                            .textFieldStyle(.plain)
                            .border(.primary.opacity(0.4))
                        
                        TextField("Ort", text: $viewModel.location)
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
                                let newAdress = Adress(
                                    firstName: viewModel.firstName,
                                    secondName: viewModel.secondName,
                                    street: viewModel.street,
                                    houseNumber: viewModel.houseNumber,
                                    plz: viewModel.plz,
                                    location: viewModel.location
                                )
                                viewModelFirestore.updateUserAdress(adress: newAdress)
                                
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    viewModel.firstName = ""
                                    viewModel.secondName = ""
                                    viewModel.street = ""
                                    viewModel.houseNumber = ""
                                    viewModel.plz = ""
                                    viewModel.location = ""
                                    
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
//        }
    }
}

#Preview {
    AdressView(viewModel: AdressViewModel(), viewModelFirestore: FirestoreViewModel())
}
