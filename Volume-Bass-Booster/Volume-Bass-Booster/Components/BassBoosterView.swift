//
//  BassBoosterView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 5.08.24.
//

import SwiftUI

struct BassBoosterView: View {
    @Binding var bassLevel: Double

    var body: some View {
        VStack {
            HStack {
                Text("Bass Booster")
                    .font(.custom("Archivo", size: 18))
                    .foregroundColor(.white)
                    .bold()
                    .padding(.trailing)
                
                Spacer()

                Text("\(Int(bassLevel))%")
                    .font(.custom("Archivo", size: 18))
                    .foregroundColor(.gray)
            }
           
            Slider(value: $bassLevel, in: 0...1000, step: 1)
                .tint(Color.theme.yellowColor)
        }
        .padding()
        .frame(width: .infinity, height: 113)
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
