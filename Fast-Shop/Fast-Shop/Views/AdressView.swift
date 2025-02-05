//
//  AdressView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 05.02.25.
//

import SwiftUI

struct AdressView: View {
    
    @ObservedObject var viewModel: ProductViewModel
    
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
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "largecircle.fill.circle")
                    .padding(.trailing, 8)
                VStack (alignment: .leading){
                    HStack {
                        Text(viewModel.user.firstName)
                        Text(viewModel.user.secondName)
                    }
                    HStack {
                        Text(viewModel.user.adress)
                        Text(viewModel.user.houseNumber)
                    }
                    HStack {
                        Text("\(viewModel.user.plz),")
                        Text(viewModel.user.location)
                    }
                }
            }
            HStack {
                    Button {
                        //Placeholder
                    } label: {
                        Image(systemName: "plus")
                            .padding(.trailing, 8)
                        Text("Neue Adresse hinzufügen")
                        
                    }
                    .tint(.primary)
                
            }
            .padding()
            
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
                
                Button("Stornieren") {
                    
                }
                Button("Speichern") {
                    
                }
                .frame(maxWidth: 400, maxHeight: 60)
                .border(.primary)
                .foregroundStyle(.primary)
            }
            .padding()

        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AdressView(viewModel: ProductViewModel())
}
