//
//  CustomSegmentedControl.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 2.08.24.
//

import SwiftUI

enum Category: String, CaseIterable {
    case audio = "Audio"
    case video = "Video"
}

struct CustomSegmentedControl: View {
    @Binding var selectedSegment: Category
    @Namespace private var animation
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Category.allCases, id: \.self) { category in
                Text(category.rawValue)
                    .fontWeight(.bold)
                    .foregroundColor(selectedSegment == category ? .black : .white)
                    .font(.custom("Archivo", size: 13))
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .frame(height: 41)
                    .background {
                        if category == selectedSegment {
                            Capsule()
                                .fill(Color.theme.yellowColor)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedSegment = category
                        }
                    }
            }
        }
        .background(Color.black.opacity(0.15).clipShape(Capsule()))
        .padding(.top, 5)
    }
}

struct CustomSegmentedControl_Previews: PreviewProvider {
    @State static var selectedSegment: Category = .audio

    static var previews: some View {
        CustomSegmentedControl(selectedSegment: $selectedSegment)
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color.black)
    }
}
