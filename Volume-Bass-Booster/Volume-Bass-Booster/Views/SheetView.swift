//
//  SheetView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 3.08.24.
//

import SwiftUI

struct SheetView: View {
    var title: String
    var content: String
    var image: String
    var button1: Config
    var button2: Config?
    @ObservedObject var photoLibraryManager: PhotoLibraryManager
    @Binding var showSheet: Bool

    var body: some View {
        VStack(spacing: 15) {
            Image(image)
                .resizable()
                .frame(width: 65, height: 65)
            
            Text(title)
                .font(.custom("Archivo", size: 24))
                .bold()
            
            Text(content)
                .font(.custom("Archivo", size: 15))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundStyle(.white)
            
            ButtonView(button1, action: photoLibraryManager.openSettings)
            if let button2 {
                ButtonView(button2) {
                    showSheet = false
                }
            }
            
        }
        .padding([.horizontal, .bottom], 15)
        .background {
            RoundedRectangle(cornerRadius: 30)
            
                .fill(.background)
                .padding(.top, 30)
        }
        .shadow(color: .black.opacity(0.12), radius: 8)
        .padding(.horizontal, 15)
        
    }

    @ViewBuilder
    func ButtonView(_ config: Config, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(config.content)
                .font(.custom("Archivo", size: 16))
                .foregroundStyle(config.foreground)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(config.tint.gradient, in: .rect(cornerRadius: 30))
        }
    }
    
    struct Config {
        var content: String
        var tint: Color
        var foreground: Color
    }
}
