//
//  PhotoLibraryManager.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 2.08.24.
//

import PhotosUI
import SwiftUI

class PhotoLibraryManager: ObservableObject {
    @Published var showingPermissionSheet = false
    @Published var showingVideoPicker = false
    @Published var selectedVideoURL: URL?

    func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .limited:
                    self.showingVideoPicker = true
                case .denied, .restricted:
                    self.showingPermissionSheet = true
                case .notDetermined:
                    break
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
