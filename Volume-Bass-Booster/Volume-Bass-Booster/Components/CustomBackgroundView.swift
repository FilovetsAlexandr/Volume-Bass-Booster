//
//  CustomBackgroundView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 30.07.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct BackgroundImageModel: Hashable {
    let title: String
    let positionWidth: CGFloat
    let positionHeight: CGFloat
    let height: CGFloat
}

struct CustomBackgroundView: View {
    var images: [BackgroundImageModel]
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(images, id: \.self) { image in
                if image.title.hasSuffix(".gif") {
                    // Использование AnimatedImage для GIF
                    AnimatedImage(name: image.title)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: image.height)
                        .position(
                            x: geometry.size.width * image.positionWidth,
                            y: geometry.size.height * image.positionHeight
                        )
                } else {
                    // Использование обычного Image для других изображений
                    Image(image.title)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: image.height)
                        .position(
                            x: geometry.size.width * image.positionWidth,
                            y: geometry.size.height * image.positionHeight
                        )
                }
            }
        }
    }
}

