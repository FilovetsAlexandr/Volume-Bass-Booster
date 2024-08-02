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
    @State var isAnimating = true
    @StateObject private var photoLibraryManager = PhotoLibraryManager()
    
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
                // MARK: -- Galery & Files
                HStack {
                    Gallery(photoLibraryManager: photoLibraryManager)
                    Files()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationBarBackButtonHidden(true)
        }
        .sheet(isPresented: $photoLibraryManager.showingVideoPicker) {
            VideoPickerView(selectedVideoURL: $photoLibraryManager.selectedVideoURL)
        }
        .sheet(isPresented: $photoLibraryManager.showingPermissionSheet) {
            PermissionSheetView(photoLibraryManager: photoLibraryManager)
        }
    }
}

#Preview {
    MainView()
}
