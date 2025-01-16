//
//  SettingsView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 16.01.25.
//

import SwiftUI

struct SettingsView: View {
    
    let randomList = ["Meine Marken", "Push-Mitteilung", "Customer-Service", "Email schreiben", "Problem melden", "Datenschutzerklärung", "Datenschutzeinstellungen", "Impressum & AGB"]

    var body: some View {
        NavigationStack {
            
            VStack {
            
                
                HStack {
                    Image(systemName: "person")
                    Text("test@mail.com")
                        .tint(.secondary)
                    Spacer()
                    
                    Text("Abmelden")
                        .foregroundStyle(.primary)
                        .underline()
                        .opacity(0.8)
                    
                    
                }
                .padding()
                .foregroundStyle(.secondary)
                
                Text("Ich shoppe für")
                    .opacity(0.8)
                    .padding(.top, 20)
                
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
                    .padding(.horizontal, 5)
                    
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
                    
                    HStack {
                        Image(systemName: "bookmark.fill")
                        NavigationLink(item){
                            //
                        }
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.visible)
                .padding()
                
                HStack {
                    VStack {
                        Text("Bewerte")
                            .font(.title3)
                            .fontDesign(.serif)
                        Text("unsere App")
                            .font(.title3)
                            .fontDesign(.serif)
                        HStack {
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        .foregroundStyle(.pink)
                    }
                    .frame(maxWidth: 150)

                    Divider()

                    VStack {
                        Text("App weiter empfehlen")
                            .font(.title3)
                            .fontDesign(.serif)
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(.secondary)
                            .padding(.top, -5)
                    }
                    .frame(maxWidth: 150)


                }
                
                NavigationLink("Account löschen >"){
                    
                }
                .tint(.secondary)
                .padding(.top)
                    
                
            
            }
            
            
            
            
            
            
            
//                .toolbar {
//                    ToolbarItem(placement: ToolbarItemPlacement.topBarLeading) {
//                        HStack {
//                            Image(systemName: "person")
//                            Text("test@mail.com")
//                                .tint(.secondary)
//                        }
//                        .foregroundStyle(.secondary)
//                    }
//                    ToolbarItem(placement: ToolbarItemPlacement.topBarTrailing) {
//                        
//                            Text("Abmelden")
//                            .foregroundStyle(.primary)
//                            .underline()
//                            .opacity(0.8)
//                    }
//                }
                .navigationTitle("Konto")
                .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        }
    }
}

#Preview {
    SettingsView()
}
