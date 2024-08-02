//
//  SettingsView.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 2.08.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var router: Router
    
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
                Text("Settings")
                    .font(.custom("Archivo", size: 18))
                    .bold()
                Spacer()
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .hidden()
            }
            .padding()
            
            VStack(spacing: 8) {
                SettingsRow(imageName: "contact-us", title: "Contact Us")
                SettingsRow(imageName: "rate-us", title: "Rate Us")
                SettingsRow(imageName: "share-app", title: "Share app")
                SettingsRow(imageName: "restore-purchases", title: "Restore Purchases")
                SettingsRow(imageName: "terms-of-use", title: "Terms of Use")
                SettingsRow(imageName: "privacy-policy", title: "Privacy Policy")
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
    }
}

struct SettingsRow: View {
    var imageName: String
    var title: String
    
    var body: some View {
        Button {
            // row
        } label: {
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 54, height: 54)
                Text(title)
                    .font(.custom("Archivo", size: 15))
                    .foregroundColor(.white)
                Spacer()
                Image("arrow_right")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
        }
        .padding()
        .frame(height: 74)
//        .background(Color.black.opacity(0.2))
        .background(Color.white.opacity(0.07))
        .cornerRadius(30)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(Router())
    }
}
