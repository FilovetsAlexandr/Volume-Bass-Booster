//
//  PhotoLibraryManager.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 2.08.24.
//

import PhotosUI
import SwiftUI

class PhotoLibraryManager: NSObject, ObservableObject, PHPickerViewControllerDelegate {
    @Published var showingPermissionSheet = false
    @Published var authorizationStatus = PHAuthorizationStatus.notDetermined
    
    override init() {
        super.init()
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
    
    // MARK: - PHPickerViewControllerDelegate Methods
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        guard let provider = results.first?.itemProvider else { return }
        if provider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
            provider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { (url, error) in
                DispatchQueue.main.async {
                    if let url = url {
                        // Дальнейшие действия с выбранным видео
                    }
                }
            }
        }
    }
}
