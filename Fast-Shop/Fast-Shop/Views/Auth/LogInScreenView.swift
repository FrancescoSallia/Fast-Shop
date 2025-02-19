//
//  APITestView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 20.01.25.
//

import AVFoundation
import AVKit
import SwiftUI

struct LogInScreenView: View {

    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var errorHandler = ErrorHandler.shared
    var body: some View {
        NavigationStack {
            ZStack {
                VideoBackgroundView()
                    .ignoresSafeArea()

                VStack {
                    ZStack {
                        Group {
                            RoundedRectangle(cornerRadius: 3)
                                .frame(width: 230, height: 90)
                                .foregroundStyle(.white.opacity(0.5))
                                .border(.black.opacity(0.4))
                                .padding(.top, -226)

                            VStack(alignment: .leading) {
                                Text("FAST-SHOP")
                                    .fontDesign(.serif)
                                    .font(.largeTitle)
                                    .padding(.top, -200)
                            }
                        }
                        .padding(.top, 90)
                    }

                    TextField("E-Mail", text: $authViewModel.email)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                        .padding(.top, 30)
                        .onSubmit {
                            return
                        }

                    SecureField("Passwort", text: $authViewModel.password)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                        .onSubmit {
                            authViewModel.login()
                        }

                    HStack {
                        NavigationLink("Passwort vergessen?") {
                            ResetPasswordView(authViewModel: authViewModel)
                        }
                        .underline()
                        .foregroundStyle(.black)
                        .font(.subheadline)
                        .padding(.bottom, 20)
                        .padding(.leading, 8)
                        .padding(.top, 4)
                        Spacer()
                    }

                    VStack {

                        NavigationLink(
                            destination: {
                                RegisterViewSheet(authViewModel: authViewModel)
                            },
                            label: {
                                Text("Registrieren")
                                    .textCase(.uppercase)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white.opacity(0.9))
                                    .cornerRadius(3)
                            })
                        Button(action: {
                            authViewModel.login()
                        }) {
                            Text("Anmelden")
                                .textCase(.uppercase)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black.opacity(0.85))
                                .cornerRadius(3)
                        }

//                        HStack(spacing: 25.0) {
//                            Button(action: {
//                                //placeholder
//                            }) {
//
//                                Image("Google")
//                                    .resizable()
//                                    .buttonBorderShape(.circle)
//                                    .frame(maxWidth: 25, maxHeight: 25)
//                                    .padding()
//                                    .background(Color.white)
//                                    .clipShape(.rect(cornerRadius: 100))
//
//                            }
//                            Button(action: {
//                                //placeholder
//                            }) {
//
//                                Image(systemName: "applelogo")
//
//                                    .buttonBorderShape(.circle)
//                                    .frame(maxWidth: 25, maxHeight: 25)
//                                    .padding()
//                                    .background(Color.black)
//                                    .foregroundStyle(.white)
//                                    .clipShape(.rect(cornerRadius: 100))
//                            }
//                            Button(action: {
//                                //placeholder
//                            }) {
//
//                                Image("Facebook")
//                                    .resizable()
//                                    .buttonBorderShape(.circle)
//                                    .frame(maxWidth: 25, maxHeight: 25)
//                                    .padding()
//                                    .background(Color.blue)
//                                    .foregroundStyle(.red)
//                                    .clipShape(.rect(cornerRadius: 100))
//                            }
//                        }
//                        .padding(.top, 35)
                    }
                    .padding(.top, 28)
                }
                .padding()
                .padding(.top, 80)
            }
        }
        .alert(isPresented: $errorHandler.showError) {
            Alert(title: Text("Error"), message: Text(errorHandler.errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}
#Preview {
    LogInScreenView(authViewModel: AuthViewModel())
}
