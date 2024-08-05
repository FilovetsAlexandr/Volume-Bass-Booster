//
//  SoundSettingsView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 2.08.24.
//

import SwiftUI
import AVKit

struct SoundSettingsView: View {
//    let videoURL: URL
    @State private var player = AVPlayer()
    @State private var isPlaying = true
    @State private var bassBooster: Float = 0
    @State private var volumeAmplifier: Float = 0
    @State private var selectedTab: Tab = .boosted
    @EnvironmentObject var router: Router

    enum Tab {
        case original, boosted
    }

    var body: some View {
        VStack {
            HStack {
                Button {
                    router.navigateBack()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                Spacer()
                Text("Sound Settings")
                    .font(.custom("Archivo", size: 18))
                    .bold()
                Spacer()
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .hidden()
            }
            .padding()

            VStack {
                SliderView(label: "Bass Booster", value: $bassBooster)
                SliderView(label: "Volume Amplifier", value: $volumeAmplifier)

                VideoPlayer(player: player)
                    .onAppear {
//                        player = AVPlayer(url: videoURL)
                        player.play()
                    }
                    .frame(height: 250)

                HStack {
                    Text("VideoName_088")
                        .font(.custom("Archivo", size: 16))
                    Spacer()
                    Text("video file")
                        .font(.custom("Archivo", size: 14))
                        .foregroundColor(.gray)
                }
                .padding()

                VideoControls(player: $player, isPlaying: $isPlaying)

                Picker("", selection: $selectedTab) {
                    Text("Original").tag(Tab.original)
                    Text("Boosted").tag(Tab.boosted)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

struct SliderView: View {
    let label: String
    @Binding var value: Float

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.custom("Archivo", size: 16))
                .bold()
            Slider(value: $value, in: 0...100)
                .accentColor(.yellow)
            Text("\(Int(value))%")
                .font(.custom("Archivo", size: 14))
                .foregroundColor(.gray)
        }
        .padding()
    }
}

struct VideoControls: View {
    @Binding var player: AVPlayer
    @Binding var isPlaying: Bool

    var body: some View {
        HStack {
            Text("\(currentTime())")
            Slider(value: Binding(
                get: {
                    Double(player.currentTime().seconds)
                },
                set: { newValue in
                    let time = CMTime(seconds: newValue, preferredTimescale: 600)
                    player.seek(to: time)
                }
            ), in: 0...Double(player.currentItem?.duration.seconds ?? 0))
            Text("\(duration())")
            Button(action: {
                if isPlaying {
                    player.pause()
                } else {
                    player.play()
                }
                isPlaying.toggle()
            }) {
                Image(systemName: isPlaying ? "pause" : "play")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
        .padding()
    }

    func currentTime() -> String {
        let seconds = player.currentTime().seconds
        return formatTime(seconds: seconds)
    }

    func duration() -> String {
        let seconds = player.currentItem?.duration.seconds ?? 0
        return formatTime(seconds: seconds)
    }

    func formatTime(seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

//#Preview {
//    SoundSettingsView()
//}


