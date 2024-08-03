//
//  SoundSettingsView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 2.08.24.
//

import SwiftUI

struct SoundSettingsView: View {
    @EnvironmentObject var router: Router
    @State private var bassBoost: Double = 0
    @State private var volumeAmplifier: Double = 0

    var body: some View {
        VStack {
            HStack {
                Button {
                    router.navigateBack()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
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

            // Слайдер для Bass Booster
            HStack {
                Text("Bass Booster")
                Slider(value: $bassBoost, in: 0...100)
                    .accentColor(.yellow)
                Text("\(Int(bassBoost))%")
            }
            .padding()

            // Слайдер для Volume Amplifier
            HStack {
                Text("Volume Amplifier")
                Slider(value: $volumeAmplifier, in: 0...100)
                    .accentColor(.yellow)
                Text("\(Int(volumeAmplifier))%")
            }
            .padding()

            // Пример видео миниатюры
            Image(systemName: "video")
                .resizable()
                .frame(width: 300, height: 200)
                .padding()

            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .foregroundColor(.white)
    }
}

#Preview {
    SoundSettingsView()
}

