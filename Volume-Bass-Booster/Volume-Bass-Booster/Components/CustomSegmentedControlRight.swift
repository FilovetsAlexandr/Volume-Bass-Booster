//
//  CustomSegmentedControlRight.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 5.08.24.
//

import SwiftUI

enum CategoryRight: String, CaseIterable {
    case original = "Original"
    case boosted = "Boosted"
}

struct CustomSegmentedControlRight: View {
    @Binding var selectedSegment: CategoryRight
    @Namespace private var animation
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(CategoryRight.allCases, id: \.self) { category in
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
        .background(Color.white.opacity(0.07).clipShape(Capsule()))
        .padding(.top, 5)
    }
}

struct CustomSegmentedControlRight_Previews: PreviewProvider {
    @State static var selectedSegment: CategoryRight = .boosted

    static var previews: some View {
        CustomSegmentedControlRight(selectedSegment: $selectedSegment)
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color.black)
    }
}

