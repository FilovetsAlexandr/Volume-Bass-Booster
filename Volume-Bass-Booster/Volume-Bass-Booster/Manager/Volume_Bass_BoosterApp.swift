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
                               if let fileURL = router.selectedFileURL {
                                   SoundSettingsRightView()
                               } else {
                                   Text("No file selected")
                               }
                           }
                       }
               }
               .environmentObject(router)
               .environment(\.colorScheme, .dark)

           }
       }
}
