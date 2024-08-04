//
//  test.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 30.07.24.
//

import SwiftUI
import PhotosUI
import SDWebImageSwiftUI

struct Gallery: View {
    @ObservedObject var photoLibraryManager: PhotoLibraryManager
    @Binding var showSheet: Bool

    var body: some View {
        VStack {
            Image("gallery")
                .resizable()
                .frame(width: 105, height: 105)
                .scaledToFit()
                .padding()
            Button {
                photoLibraryManager.requestPhotoLibraryAccess()
                if photoLibraryManager.showingPermissionSheet {
                    showSheet = true
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.theme.yellowColor)
                        .frame(width: 155, height: 54)
                    HStack {
                        Image("black_plus")
                            .resizable()
                            .frame(width: 22, height: 22)
                        Text("Gallery")
                            .font(.custom("Archivo", size: 16))
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .padding()
        .frame(width: 176, height: 238)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.07))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.1), lineWidth: 2)
                )
        )
    }
}


//#Preview {
//    Gallery()
//}
