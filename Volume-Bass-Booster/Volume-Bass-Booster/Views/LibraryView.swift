//
//  LibraryView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 2.08.24.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var router: Router
    @State private var selectedSegment: Category = .audio
    @State private var audioFiles: [String] = []
    @State private var videoFiles: [String] = []

    var body: some View {
        VStack {
            HStack {
                Button {
                    router.navigateBack()
                } label: {
                    Image("arrow_left")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                Spacer()
                Text("My Library")
                    .font(.custom("Archivo", size: 18))
                    .bold()
                Spacer()
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .hidden()
            }
            .padding()

            CustomSegmentedControl(selectedSegment: $selectedSegment)
                .padding(.horizontal)
                .padding(.bottom, 20)

            if selectedSegment == .audio {
                if audioFiles.isEmpty {
                    EmptyLibraryView(isAudio: true)
                } else {
                    List(audioFiles, id: \.self) { file in
                        Text(file) // Customize this to show audio file details
                    }
                }
            } else {
                if videoFiles.isEmpty {
                    EmptyLibraryView(isAudio: false)
                } else {
                    List(videoFiles, id: \.self) { file in
                        Text(file) // Customize this to show video file details
                    }
                }
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear(perform: loadFiles)
        .navigationBarBackButtonHidden(true)
    }

    private func loadFiles() {
        // Load audio and video files using FileManager
        audioFiles = loadFilesFromDirectory(directory: "AudioFiles")
        videoFiles = loadFilesFromDirectory(directory: "VideoFiles")
    }

    private func loadFilesFromDirectory(directory: String) -> [String] {
        let fileManager = FileManager.default
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

struct EmptyLibraryView: View {
    @EnvironmentObject var router: Router
    var isAudio: Bool

    var body: some View {
        VStack {
            Spacer()
            Text("Nothing here yet")
                .font(.custom("Archivo", size: 24))
                .foregroundColor(.white)
                .bold()
            Text(isAudio ? "Amplify your first audio." : "Upgrade your first video.")
                .font(.custom("Archivo", size: 15))
                .foregroundColor(.white)
                .padding(.top, 8)
            Button {
                router.navigateBack()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.theme.yellowColor)
                        .frame(width: 270, height: 66)

                    Text("Boost")
                        .font(.custom("Archivo", size: 16))
                        .foregroundColor(.black)
                        .bold()
                }
            }
            .padding(.top, 20)
            Spacer()
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
            .environmentObject(Router())
    }
}
