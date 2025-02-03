//
//  APITestView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 20.01.25.
//

import SwiftUI
import AVFoundation
import AVKit

struct APITestView: View {

    var body: some View {
        ZStack {
                    VideoBackgroundView()
                        .ignoresSafeArea() // Deckt den ganzen Bildschirm ab
            
            VStack {
          TextField("E-Mail", text: .constant(""))
                    .padding()
                    .background(Color(uiColor: UIColor.lightText))
                    .cornerRadius(10)
                    .keyboardType(.emailAddress)
                    .padding(.top, 30)
                
          SecureField("Passwort", text: .constant(""))
                    .padding()
                    .background(Color(uiColor: UIColor.lightText))
                    .cornerRadius(10)
          
          HStack {
              Button("Passwort vergessen?") {
                  
              }
              .underline()
              .foregroundStyle(.black)
              .font(.subheadline)
              .padding(.bottom, 20)
              .padding(.leading, 8)
                  Spacer()
          }
                
                Button(action: {
                  //placeholder
                }) {
                    Text("Anmelden")
                        .textCase(.uppercase)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(3)
                }
                Button(action: {
                  //placeholder
                }) {
                    Text("Registrieren")
                        .textCase(.uppercase)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(3)
                }
            }
            .padding()
            .padding(.top, 80)
                    
//                    VStack {
//                        Text("Willkommen")
//                            .font(.largeTitle)
//                            .foregroundColor(.white)
//                            .bold()
//                            .padding()
//                    }
                }
    }
}
#Preview {
    APITestView()
}



