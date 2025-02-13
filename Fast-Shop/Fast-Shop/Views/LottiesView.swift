//
//  LottiesView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 13.02.25.
//

import SwiftUI
import Lottie

struct LottiesView: View {
    @State private var textOffset: CGFloat = 300  // Startet außerhalb des Bildschirms

    var body: some View {
        ZStack {
            LottieView(animation: .named("animationSuccessfull"))
                .playing(.fromProgress(0.0, toProgress: 1.0, loopMode: .playOnce))
                .animationSpeed(0.9)
                .padding(.bottom, 200)

            Text("Vielen Dank für Ihre Bestellung!")
                          .fontDesign(.rounded)
                          .fontWeight(.bold)
                          .font(.title2)
                          .offset(y: textOffset)  // Offset steuert die Position auf der y-Achse
                          .animation(.easeOut(duration: 2), value: textOffset)
                          .onAppear {
                              textOffset = 40  // Zielposition (Mitte des Bildschirms)
                          }
        }
    }
}
#Preview {
    LottiesView()
}
