//
//  CompressVideoView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 2.08.24.
//

import SwiftUI
import AVKit

struct CompressVideoView: View {
    @EnvironmentObject var router: Router
    @State private var player = AVPlayer()
    @Binding var videoURL: URL?

    var body: some View {
        VStack {
            Text("Choose Video")
                .font(.custom("Archivo", size: 24))
                .bold()
                .padding()

            if let videoURL = videoURL {
                VideoPlayer(player: player)
                    .frame(height: 200)
                    .onAppear {
                        player.replaceCurrentItem(with: AVPlayerItem(url: videoURL))
                        player.play()
                    }
            } else {
                Image(systemName: "video")
                    .resizable()
                    .frame(width: 300, height: 200)
                    .padding()
            }

            HStack {
                Button("Cancel") {
                    videoURL = nil
                    router.navigate(to: .main)
                }
                .font(.custom("Archivo", size: 18))
                .foregroundColor(.red)
                .padding()

                Spacer()

                Button("Choose") {
                    router.navigate(to: .soundsettings)
                }
                .font(.custom("Archivo", size: 18))
                .foregroundColor(.blue)
                .padding()
            }
            .padding()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .foregroundColor(.white)
    }
}

#Preview {
    CompressVideoView(videoURL: .constant(nil))
}
