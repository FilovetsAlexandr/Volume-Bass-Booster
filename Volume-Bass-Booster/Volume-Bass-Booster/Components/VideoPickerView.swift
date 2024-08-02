//
//  VideoPickerView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 2.08.24.
//

import SwiftUI
import PhotosUI

struct VideoPickerView: UIViewControllerRepresentable {
    @Binding var selectedVideoURL: URL?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .videos
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: VideoPickerView

        init(_ parent: VideoPickerView) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.selectedVideoURL = nil
            guard let provider = results.first?.itemProvider else {
                picker.dismiss(animated: true, completion: nil)
                return
            }
            if provider.hasItemConformingToTypeIdentifier(UTType.movie.identifier as String) {
                provider.loadItem(forTypeIdentifier: UTType.movie.identifier as String, options: nil) { (url, error) in
                    DispatchQueue.main.async {
                        self.parent.selectedVideoURL = url as? URL
                    }
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

