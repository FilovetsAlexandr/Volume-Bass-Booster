//
//  PhotoLibraryManager.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 2.08.24.
//

import SwiftUI
import Photos

class PhotoLibraryManager: ObservableObject {
    @Published var showingPermissionSheet = false

    func requestPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    self.showingPermissionSheet = false
                case .denied, .restricted:
                    self.showingPermissionSheet = true
                case .notDetermined:
                    self.showingPermissionSheet = true
                case .limited:
                    self.showingPermissionSheet = false
                @unknown default:
                    break
                }
            }
        }
    }
    
    func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
}


