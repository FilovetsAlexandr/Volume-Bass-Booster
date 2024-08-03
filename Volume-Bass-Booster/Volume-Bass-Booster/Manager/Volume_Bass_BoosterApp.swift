//
//  Volume_Bass_BoosterApp.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 30.07.24.
//

import SwiftUI

@main
struct Volume_Bass_BoosterApp: App {
    @ObservedObject var router = Router()
       
       var body: some Scene {
           WindowGroup {
               NavigationStack(path: $router.navPath) {
                   SplashView()
                       .navigationDestination(for: Router.Destination.self) { destination in
                           switch destination {
                           case .main:
                               MainView()
                           case .settings:
                               SettingsView()
                           case .library:
                               LibraryView()
                           case .soundsettings:
                               SoundSettingsView()
//                           case .compressvideo(let videoURL): // Обработка параметра videoURL
//                               CompressVideoView(videoURL: videoURL)
                           }
                       }
               }
               .environmentObject(router)
               .environment(\.colorScheme, .dark)

           }
       }
}
