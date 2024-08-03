//
//  SplashViewModel.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 30.07.24.
//

import Foundation
import Combine

class SplashViewModel: ObservableObject {
    @Published var isActive: Bool = false

    func startLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isActive = true
        }
    }
}
