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
            Image(systemName: "photo")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
                .padding(.top, 20)
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
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            Button(action: {
                photoLibraryManager.showingPermissionSheet = false
            }) {
                Text("Cancel")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            Spacer()
        }
        .padding()
        .background(Color.black)
        .cornerRadius(20)
        .shadow(radius: 20)
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.main.bounds.height / 2)
    }
}



struct PermissionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionSheetView(photoLibraryManager: PhotoLibraryManager())
    }
}
