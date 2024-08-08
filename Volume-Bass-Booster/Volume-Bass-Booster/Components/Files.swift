//
//  Files.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 31.07.24.
//

import SwiftUI
import UniformTypeIdentifiers

struct Files: View {
    @State private var isDocumentPickerPresented = false
    @State private var selectedFileURL: URL?
    @EnvironmentObject var router: Router
    var body: some View {
        VStack {
            Image("files")
                .resizable()
                .frame(width: 105, height: 105)
                .scaledToFit()

                .padding()
            Button {
                isDocumentPickerPresented = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.theme.yellowColor)
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
        
        .fileImporter(
                   isPresented: $isDocumentPickerPresented,
                   allowedContentTypes: [UTType.mp3, UTType.movie],
                   allowsMultipleSelection: false
               ) { result in
                   switch result {
                   case .success(let urls):
                       if let selectedFileURL = urls.first {
                           self.selectedFileURL = selectedFileURL
                           // Переход к SoundSettingsRightView с использованием роутера и передачей URL файла
                           router.selectedFileURL = selectedFileURL
                           router.navigate(to: .soundsettings) // Установите URL файла в роутере или в другой глобальной переменной
                       }
                   case .failure(let error):
                       print("Ошибка при выборе файла: \(error.localizedDescription)")
                   }
               }
           }
       }

#Preview {
    Files()
}
