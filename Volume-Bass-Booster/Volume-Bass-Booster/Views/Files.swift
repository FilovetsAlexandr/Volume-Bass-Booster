//
//  Files.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 31.07.24.
//

import SwiftUI

struct Files: View {
    var body: some View {
        VStack {
            Image("files")
                .resizable()
                .frame(width: 105, height: 105)
                .scaledToFit()

                .padding()
            Button {
                // galery open
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.yellow)
                        .frame(width: 155, height: 54)
                    HStack {
                        Image("black_plus")
                            .resizable()
                            .frame(width: 22, height: 22)
                        Text("Files")
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

#Preview {
    Files()
}
