//
//  VideoBackgroundView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 03.02.25.
//

import SwiftUI
import AVKit

struct VideoBackgroundView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        
        // Hole die Video-URL aus dem Bundle
        guard let path = Bundle.main.path(forResource: "FastShopBackground", ofType: "mp4") else {
            print("⚠️ Video nicht gefunden!")
            return controller
        }
        let url = URL(fileURLWithPath: path)
        
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        
        // Vollbild-Anpassungen
        playerLayer.frame = UIScreen.main.bounds
        playerLayer.videoGravity = .resizeAspectFill // Video füllt den ganzen Bildschirm
        
        controller.view.layer.addSublayer(playerLayer)
        
        // Video in Endlosschleife abspielen
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            player.seek(to: .zero)
            player.play()
        }
        
        player.play() // Startet das Video sofort
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
#Preview {
    VideoBackgroundView()
}
