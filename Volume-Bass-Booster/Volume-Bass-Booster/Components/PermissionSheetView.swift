//
//  PermissionSheetView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 2.08.24.
//

import SwiftUI

struct PermissionSheetView: View {
    @ObservedObject var photoLibraryManager: PhotoLibraryManager
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "photo")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
            Text("Enable access to your Photos")
                .font(.custom("Archivo", size: 18))
                .foregroundColor(.white)
                .padding(.top, 20)
            Text("For editing and saving video and audio files, please enable Photos access in your iPhone settings.")
                .font(.custom("Archivo", size: 15))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
            Button(action: {
                photoLibraryManager.openSettings()
            }) {
                Text("Go to Settings")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10)
            }
            Button(action: {
                photoLibraryManager.showingPermissionSheet = false
            }) {
                Text("Cancel")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                    .padding(.top, 10)
            }
            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
