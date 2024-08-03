//
//  SplashView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 30.07.24.
//

import SwiftUI

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var router: Router
    @State private var isActive = false

    var body: some View {
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    router.navigate(to: .main)
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView().environmentObject(Router())
    }
}
