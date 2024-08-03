//
//  PhotoLibraryManager.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 2.08.24.
//

import SwiftUI
import PhotosUI

class PhotoLibraryManager: ObservableObject {
    @Published var showingPermissionSheet = false
    @Published var authorizationStatus = PHAuthorizationStatus.notDetermined
    
    init() {
        updateAuthorizationStatus()
    }
    
    func updateAuthorizationStatus() {
        authorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
    }
    
    func requestPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] newStatus in
                DispatchQueue.main.async {
                    self?.updateAuthorizationStatus()
                    if newStatus != .authorized {
                        self?.showingPermissionSheet = true
                    }
                }
            }
        case .denied, .restricted:
            showingPermissionSheet = true
        case .authorized, .limited:
            updateAuthorizationStatus()
        @unknown default:
            break
        }
    }
    
    func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsURL)
    }
}
