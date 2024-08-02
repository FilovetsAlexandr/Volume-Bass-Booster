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
                    Image(systemName: "chevron.left")
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
            
            Spacer(minLength: 20)
            
            VStack(spacing: 10) {
                SettingsRow(imageName: "envelope.fill", title: "Contact Us")
                SettingsRow(imageName: "hand.thumbsup.fill", title: "Rate Us")
                SettingsRow(imageName: "megaphone.fill", title: "Share app")
                SettingsRow(imageName: "lock.fill", title: "Restore Purchases")
                SettingsRow(imageName: "doc.text.fill", title: "Terms of Use")
                SettingsRow(imageName: "shield.fill", title: "Privacy Policy")
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct SettingsRow: View {
    var imageName: String
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.yellow)
                .padding()
                .background(Circle().fill(Color.black.opacity(0.6)))
            Text(title)
                .font(.custom("Archivo", size: 18))
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 12, height: 24)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .cornerRadius(15)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(Router())
    }
}
