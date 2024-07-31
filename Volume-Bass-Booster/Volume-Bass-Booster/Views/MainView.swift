//
//  MainView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 30.07.24.
//

import SDWebImageSwiftUI
import SwiftUI

struct MainView: View {
    @State var isAnimating = true
    var body: some View {
        // MARK: -- Background
        ZStack {
            CustomBackgroundView(images: [
                BackgroundImageModel(
                    title: "fire.gif",
                    positionWidth: 0.5,
                    positionHeight: 0.135,
                    height: 450),
                BackgroundImageModel(
                    title: "gradientTop",
                    positionWidth: 0.5,
                    positionHeight: 0.015,
                    height: 80),
                BackgroundImageModel(
                    title: "gradientBottom",
                    positionWidth: 0.5,
                    positionHeight: 0.255,
                    height: 80)
            ])
            // MARK: -- Main Stack
            VStack {
                // MARK: -- Library & Settings
                 HStack {
                    Button {
                        // Действие для открытия библиотеки
                    } label: {
                        Image("library")
                            .resizable()
                            .frame(width: 56, height: 56)
                            .padding()
                    }
                    Spacer()
                    Button {
                        // Действие для открытия настроек
                    } label: {
                        Image("settings")
                            .resizable()
                            .frame(width: 56, height: 56)
                            .padding()
                    }
                 }
                Text ("Volume & Bass \nBooster")
                    .font(.custom("Archivo", size: 42))
                    .bold()
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.top,15)
                Text ("Upgrade the audio quality and boost \nthe volume for clearer and louder sound")
                    .font(.custom("Archivo", size: 17))
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top,15)
                    .padding()
                Text ("Select auidio or video to boost")
                    .font(.custom("Archivo", size: 18))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top,65)
                    .padding()
                // MARK: -- Galery & Files
                 HStack {
                    Gallery()
                     Files()
                 }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

#Preview {
    MainView()
}
