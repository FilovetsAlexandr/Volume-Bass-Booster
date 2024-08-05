//
//  SoundSettingsRightView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 5.08.24.
//

import AVKit
import SwiftUI

struct SoundSettingsRightView: View {
    let audioFileName = "bird"
    
    @State private var player: AVAudioPlayer?
    @State private var selectedSegment: CategoryRight = .original
    @State private var isPlaying = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    @EnvironmentObject var router: Router
    @State private var bassLevel: Double = 0.0
    @State private var volumeLevel: Double = 0.0

    var body: some View {
        ZStack {
            VStack() {
                HStack {
                    Button {
                        router.navigateBack()
                    } label: {
                        Image("arrow_left")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    Spacer()
                    Text("Sound Settings")
                        .font(.custom("Archivo", size: 18))
                        .bold()
                    Spacer()
                    Button {
                        // download
                    } label: {
                        Image("download")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                .padding()
                VStack {
                    BassBoosterView(bassLevel: $bassLevel)
                    VolumeAmplifierView(volumeLevel: $volumeLevel)
                }
                VStack {
                    Image ("cover")
                        .resizable()
                        .frame(width: 204, height: 204)
                        .padding()
                    Text ("AudioName_088")
                        .font(.custom("Archivo", size: 16))
                    Text ("audio file")
                        .font(.custom("Archivo", size: 14))
                        .opacity(0.5)
                    
                }
                VStack() {
                    Slider(value: Binding(get: {
                        currentTime
                    }, set: { newValue in
                        seekAudio(to: newValue)
                    }), in: 0 ... totalTime)
                    .accentColor(.white)
                    .padding(.horizontal)
                    HStack {
                        Text(timeString(time: currentTime))
                            .foregroundColor(.white)
                            .font(.custom("Archivo", size: 13))
                        Spacer()
                        Text(timeString(time: totalTime))
                            .foregroundColor(.white)
                            .font(.custom("Archivo", size: 13))
                    }
                    .padding(.horizontal)
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.largeTitle)
                        .onTapGesture {
                            isPlaying ? stopAudio() : playAudio()
                        }
                }
                Spacer()
                CustomSegmentedControlRight(selectedSegment: $selectedSegment)
                
            }
        }
        .onAppear(perform: setupAudio)
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            updateProgress()
        }
    }
    
    private func setupAudio() {
        guard let url = Bundle.main.url(forResource: audioFileName, withExtension: "mp3") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            totalTime = player?.duration ?? 0.0
        } catch {
            print("Error loading audio: \(error)")
        }
    }
    
    private func playAudio() {
        player?.play()
        isPlaying = true
    }
    
    private func stopAudio() {
        player?.pause()
        isPlaying = false
    }
    
    private func updateProgress() {
        guard let player = player else { return }
        currentTime = player.currentTime
    }
    
    private func seekAudio(to time: TimeInterval) {
        player?.currentTime = time
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SoundSettingsRightView()
    }
}
