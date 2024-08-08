//
//  SoundSettingsRightView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 5.08.24.
//

import AudioKit
import AVKit
import CAudioKitEX
import SoundpipeAudioKit
import SwiftUI

struct SoundSettingsRightView: View {
    var audioFileName = "test"
    @EnvironmentObject var router: Router
    @State private var player: AVAudioPlayer?
    @State private var engine = AudioEngine()
    @State private var audioPlayer: AudioPlayer!
    @State private var bassBoost: LowShelfFilter!
    @State private var mixer: Mixer!
    @State private var selectedSegment: CategoryRight = .original {
        didSet {
            handleSegmentChange()
        }
    }
    @State private var isPlaying = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    @State private var bassLevel: Double = 0.5 {
        didSet {
            if selectedSegment == .original {
                selectedSegment = .boosted
            }
        }
    }
    @State private var volumeLevel: Double = 0.5 {
        didSet {
            if selectedSegment == .original {
                selectedSegment = .boosted
            }
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
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
                        .onChange(of: bassLevel) { newValue in
                            bassBoost.cutoffFrequency = AUValue(newValue)
                        }
                    VolumeAmplifierView(volumeLevel: $volumeLevel)
                        .onChange(of: volumeLevel) { newValue in
                            mixer.volume = AUValue(newValue)
                        }
                }
                VStack {
                    Image("cover")
                        .resizable()
                        .frame(width: 204, height: 204)
                        .padding()
                    Text("AudioName_088")
                        .font(.custom("Archivo", size: 16))
                    Text("audio file")
                        .font(.custom("Archivo", size: 14))
                        .opacity(0.5)
                }
                VStack {
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
                            isPlaying ? pauseAudio() : playAudio()
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
        guard let url = Bundle.main.url(forResource: audioFileName, withExtension: "mp3") else { return }
        
        do {
            let file = try AVAudioFile(forReading: url)
            audioPlayer = AudioPlayer(file: file)
            bassBoost = LowShelfFilter(audioPlayer, cutoffFrequency: 80, gain: 15)
            mixer = Mixer(bassBoost)
            
            mixer.volume = AUValue(volumeLevel)
            
            engine.output = mixer
            try engine.start()
            totalTime = audioPlayer.duration  // Установка общей длительности трека
        } catch {
            print("Error loading audio: \(error)")
        }
    }
    
    private func playAudio() {
        audioPlayer.play()
        isPlaying = true
    }
    
    private func pauseAudio() {
        audioPlayer.pause()
        isPlaying = false
    }
    
    private func updateProgress() {
        guard let player = audioPlayer else { return }
        currentTime = player.currentTime
    }
    
    private func seekAudio(to time: TimeInterval) {
        player?.currentTime = time
    }
    
    private func handleSegmentChange() {
        if selectedSegment == .original {
            // Сбросить ползунки к нулю
            bassLevel = 0.0
            volumeLevel = 0.0
            bassBoost.cutoffFrequency = AUValue(bassLevel)
            mixer.volume = AUValue(volumeLevel)
        }
    }

    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


struct SoundSettingsRightView_Previews: PreviewProvider {
    static var previews: some View {
        SoundSettingsRightView()
    }
}
