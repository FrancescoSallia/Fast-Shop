//
//  RegisterViewSheet.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 06.02.25.
//

import SwiftUI

struct RegisterViewSheet: View {
    @State var acceptTerms: Bool = false
    
    var body: some View {
        
        VStack(spacing: 20) {
                  Text("Registrierung")
                      .font(.largeTitle)
                      .fontWeight(.bold)
                  
            VStack(alignment: .leading) {
                Text("Vorname")
                    .padding(.bottom, -4)
                TextField("Vorname", text: .constant(""))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .border(.primary)
            }
                  
            VStack(alignment: .leading) {
                Text("Nachname")
                    .padding(.bottom, -4)
                TextField("Nachname", text: .constant(""))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .border(.primary)
            }

            VStack(alignment: .leading) {
                Text("Passwort")
                    .padding(.bottom, -4)
                SecureField("Passwort", text: .constant(""))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .border(.primary)
            }
            VStack(alignment: .leading) {
                Text("Passwort wiederholen")
                    .padding(.bottom, -4)
                SecureField("Passwort wiederholen", text: .constant(""))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .border(.primary)
            }
                  
                  Toggle(isOn: $acceptTerms) {
                      Text("Ich akzeptiere die AGB")
                  }
                  .padding(.horizontal)
                  
            Button(action: {
              //placeholder
            }) {
                Text("Registrieren")
                    .textCase(.uppercase)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(acceptTerms ? Color.primary.opacity(0.9) : .secondary.opacity(0.5))
                    .cornerRadius(3)
            }
                  .disabled(!acceptTerms)
                  
                  Spacer()
              }
              .padding()
        
 
        
 

    }
}

#Preview {
    RegisterViewSheet()
}
