//
//  LogInView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 08.01.25.
//

import SwiftUI

struct LogInView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            Spacer()
            
            Group {
                //Hier kommt das logo als Bild
                Image(systemName: "house")
                    .resizable()
                    .frame(width: 70, height: 70)
                
                Text("Einloggen oder registrieren")
                    .font(.title)
                    .bold()
                Text("Im Handumdrehen")
                    .font(.title)
            }
            .padding(.horizontal)
            
            
            Group {
                Text("E-Mail")
                    .font(.callout)
                    .padding(.horizontal)
                    .padding(.vertical, -4)
                TextField("Email", text: .constant(""))
                    .padding()
                    .border(Color.black)
                    .padding(.horizontal)
                
                Text("Passwort")
                    .font(.callout)
                    .padding(.horizontal)
                    .padding(.vertical, -0.1)
                ZStack {
                    SecureField("Passwort", text: .constant(""))
                        .padding()
                        .border(Color.black)
                        .padding(.horizontal)
                    
                    Image(systemName: "eye.slash")// und "eye" wenn es aktiviert ist
                        .offset(x: 140)
                }
                
                Button("Passwort vergessen?"){
                    
                }
                .padding(.leading, 20)
                    
                
                Button("Weiter") {
                    //
                }
                .frame(width: 338, height: 18)
                .padding()
                .background(Color.black)
                .foregroundStyle(.white)
                .padding(.horizontal)
                .padding(.vertical)
                .bold()
            }
            
            HStack {
                Text("Kein Konto?")
                Button("Konto erstellen"){
                    
                }
            }
            .padding(.leading, 20)

            
            Spacer()
            
            Group {
                
                //FIXME: man kann nur auf dem Text klicken. Ich will das der ganze rechteck anklickbar ist!
                HStack {
                    Image("Google")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .offset(x: 10)
                    Button {
                        // mit Google anmelden
                    }label: {
                        Text("Weiter mit Google")
                            .bold()
                            .foregroundStyle(.black)
                    }
                    .padding()
                }
                .padding(.horizontal)
                .frame(width: 338, height: 18)
                .padding()
                
                HStack {
                    Image("Apple")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .offset(x: 10)
                    Button {
                        // mit Google anmelden
                    }label: {
                        Text("Weiter mit Apple")
                            .bold()
                            .foregroundStyle(.black)
                    }
                    .padding()
                }
                .padding(.horizontal)
                .frame(width: 338, height: 18)
                .padding()
                
                HStack {
                    Image("Facebook")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .offset(x: 10)
                    Button {
                        // mit Google anmelden
                    }label: {
                        Text("Weiter mit Facebook")
                            .bold()
                            .foregroundStyle(.black)
                    }
                    .padding()
                    
                }
                .padding(.horizontal)
                .frame(width: 338, height: 18)
                .padding()
                
            }
            .border(Color.black,width: 2)
            .padding(.horizontal)
            
            Spacer()
           
        }
    }
}

#Preview {
    LogInView()
}
