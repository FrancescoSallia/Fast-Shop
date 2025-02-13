//
//  LogInView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 08.01.25.
//

import SwiftUI

struct LogInView: View {
    var body: some View {
        
        VStack {
            Group {
                //Hier kommt das logo als Bild
                Image(systemName: "house")
                    .resizable()
                    .frame(width: 70, height: 70)
                
                Text("Jetzt einloggen")
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .bold()
                Text("Im Handumdrehen")
                    .font(.title3)
            }
            .padding(.horizontal)
            
                  
            TextField("E-Mail", text: .constant(""))
                      .padding()
                      .background(Color(.secondarySystemBackground))
                      .cornerRadius(10)
                      .keyboardType(.emailAddress)
                      .autocapitalization(.none)
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
                          .foregroundColor(.white)
                          .frame(maxWidth: .infinity)
                          .padding()
                          .background(Color.orange)
                          .cornerRadius(10)
                  }
                  
                  // OR Divider
                  HStack {
                      Rectangle()
                          .frame(height: 1)
                          .foregroundColor(Color.gray)
                      Text("ODER")
                          .foregroundColor(.gray)
                      Rectangle()
                          .frame(height: 1)
                          .foregroundColor(Color.gray)
                  }
                  .padding(.vertical, 10)
                  
                  HStack(spacing: 10) {
                      Button(action: {
                          //placeholder
                      }) {
                          HStack {
                              Image("Google")
                                  .resizable()
                                  .frame(width: 20, height: 20)
                                  .padding(2)
                                  .background(Color.white)
                              Text("Google")
                          }
                          .foregroundColor(.white)
                          .frame(maxWidth: .infinity)
                          .padding()
                          .background(Color.blue.opacity(0.9))
                          .bold()
                          .border(.black, width: 1)

                      }
                      
                      Button(action: {
                          print("Mit Facebook anmelden")
                      }) {
                          HStack {
                              Image("Facebook")
                                  .resizable()
                                  .frame(width: 20, height: 20)
                              Text("Facebook")
                          }
                          .foregroundColor(.white)
                          .frame(maxWidth: .infinity)
                          .padding()
                          .background(Color.blue)
                          .bold()
                          .border(.black, width: 1)
                      }
                  }
                  
                  Button(action: {
                      //placeholder
                  }) {
                      HStack {
                          Image(systemName: "applelogo")
                          Text("Apple")
                      }
                      .foregroundColor(.white)
                      .frame(maxWidth: .infinity)
                      .padding()
                      .background(Color.black)
                      .bold()
                      .border(.black, width: 1)
                  }
              }
              .padding()
        
        Text("Du hast noch kein Konto?")
            .padding(.top, 20)
        Button {
            //Placeholder
        } label: {
            Text("Neues Konto erstellen")
                .foregroundStyle(.orange)
        }
    }
}

#Preview {
    LogInView()
}
