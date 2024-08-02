//
//  ContentView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 30.07.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var splashViewModel = SplashViewModel()

    var body: some View {
        if splashViewModel.isActive {
            MainView()
        } else {
            SplashView()
        }
    }
}

#Preview {
    ContentView()
}
