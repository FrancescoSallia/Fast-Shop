//
//  SettingsView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 16.01.25.
//

import SwiftUI

struct SettingsView: View {
    
    let randomList = ["text1", "text2", "text3", "text4", "text5"]

    var body: some View {
        NavigationStack {
            
            VStack {
                
                Text("Ich shoppe für")
                    .opacity(0.8)
                
                HStack {
                    Button("DAMEN"){
                        //placeholder
                    }
                    .frame(width: 150, height: 40)
                    .buttonStyle(.borderedProminent)
                    .tint(.white) // clear oder black
                    .foregroundStyle(.black) // white oder black
                    .border(Color.black, width: 1)
                    .bold()
                    .padding(.vertical)
                    
                    Button("HERREN"){
                        //placeholder
                    }
                    .frame(width: 150, height: 40)
                    .buttonStyle(.borderedProminent)
                    .tint(.black) // clear oder black
                    .foregroundStyle(.white) // white oder black
                    .border(Color.black, width: 1)
                    .bold()
                    .background(Color.black)
                    .padding(.vertical)
                    
                }
                
                List(randomList, id: \.self) { item in
                    
                    Text(item)
                }
                .listStyle(.plain)
                
            
            }
            
            
            
            
            
            
            
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.topBarLeading) {
                        HStack {
                            Image(systemName: "person")
                            Text("test@mail.com")
                                .tint(.secondary)
                        }
                        .foregroundStyle(.secondary)
                    }
                    ToolbarItem(placement: ToolbarItemPlacement.topBarTrailing) {
                        
                            Text("Abmelden")
                            .foregroundStyle(.primary)
                            .underline()
                            .opacity(0.8)
                    }
                }
        }
        
        
       
    }
}

#Preview {
    SettingsView()
}
