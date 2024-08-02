//
//  FileManager.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 2.08.24.
//

import Foundation   

class FileManagerHelper {
    static let shared = FileManagerHelper()
    private let fileManager = FileManager.default

    private init() {}

    func saveFile(data: Data, directory: String, fileName: String) -> Bool {
        guard let directoryPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(directory) else {
            return false
        }

        do {
            try fileManager.createDirectory(at: directoryPath, withIntermediateDirectories: true, attributes: nil)
            let filePath = directoryPath.appendingPathComponent(fileName)
            try data.write(to: filePath)
            return true
        } catch {
            print("Error saving file: \(error)")
            return false
        }
    }

    func loadFilesFromDirectory(directory: String) -> [String] {
        guard let directoryPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(directory) else {
            return []
        }

        do {
            let files = try fileManager.contentsOfDirectory(atPath: directoryPath.path)
            return files
        } catch {
            print("Error loading files from \(directory): \(error)")
            return []
        }
    }
}
