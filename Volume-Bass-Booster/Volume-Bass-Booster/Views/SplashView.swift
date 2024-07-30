//
//  SplashView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 30.07.24.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel: SplashViewModel

    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea(.all)
            VStack {
                Spacer()
                Image("img_splash")
                    .resizable()
                    .frame(width: 184, height: 184)
                    .padding()
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
            .onAppear {
                viewModel.startLoading()
            }
        }
    }
}

#Preview {
    SplashView(viewModel: SplashViewModel())
}
