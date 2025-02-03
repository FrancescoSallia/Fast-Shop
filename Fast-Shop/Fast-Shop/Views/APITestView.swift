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
//    @State var player = AVPlayer(url: URL(string:"https://youtu.be/9TwO9yMsPRg")!)
    @State var player = AVPlayer(url: URL(string: "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4")!)
    @State var isPlaying: Bool = false
    
    var body: some View {
        ZStack {
                    VideoBackgroundView()
                        .ignoresSafeArea() // Deckt den ganzen Bildschirm ab
            
            VStack {
          TextField("E-Mail", text: .constant(""))
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .keyboardType(.emailAddress)
//                    .autocapitalization(.none)
                    .padding(.top, 30)
                
          SecureField("Passwort", text: .constant(""))
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
          
          HStack {
              Text("Passwort vergessen?")
                  .underline()
                  .foregroundStyle(.blue)
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
                        .background(Color.secondary)
                        .cornerRadius(3)
                }
                Button(action: {
                  //placeholder
                }) {
                    Text("Registrieren")
                        .textCase(.uppercase)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.secondary)
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



