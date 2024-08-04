//
//  MainView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 30.07.24.
//

import SDWebImageSwiftUI
import SwiftUI
import PhotosUI

struct MainView: View {
    @EnvironmentObject var router: Router
    @StateObject var photoLibraryManager = PhotoLibraryManager()
    @State private var showSheet: Bool = false
    @State var isAnimating = true

    var body: some View {
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
            
            VStack {
                HStack {
                    Button {
                        router.navigate(to: .library)
                    } label: {
                        Image("library")
                            .resizable()
                            .frame(width: 56, height: 56)
                            .padding()
                    }
                    Spacer()
                    Button {
                        router.navigate(to: .settings)
                    } label: {
                        Image("settings")
                            .resizable()
                            .frame(width: 56, height: 56)
                            .padding()
                    }
                }
                
                Text("Volume & Bass \nBooster")
                    .font(.custom("Archivo", size: 42))
                    .bold()
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.top, 15)
                
                Text("Upgrade the audio quality and boost \nthe volume for clearer and louder sound")
                    .font(.custom("Archivo", size: 17))
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 15)
                    .padding()
                
                Text("Select audio or video to boost")
                    .font(.custom("Archivo", size: 18))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 65)
                    .padding()
                
                HStack {
                    Gallery(photoLibraryManager: photoLibraryManager, showSheet: $showSheet)
                    Files()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationBarBackButtonHidden(true)
        }
        .floatingBottomSheet(isPresented: $showSheet) {
            SheetView(
                title: "Enable access to your Photos",
                content: "For editing and saving video and audio files, please enable Photos access in your iPhone settings.",
                image: "gallery",
                button1: .init(
                    content: "Go to Settings",
                    tint: Color.theme.yellowColor,
                    foreground: .black),
                button2: .init(
                    content: "Cancel",
                    tint: Color.white.opacity(0.07),
                    foreground: .white
                ),
                photoLibraryManager: photoLibraryManager
            )
            .presentationDetents([.height(330)])
        }
    }
}


#Preview {
    MainView()
}
