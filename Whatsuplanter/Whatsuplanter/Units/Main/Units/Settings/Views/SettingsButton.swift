//
//  SettingsButton.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 05.02.2025.
//

import SwiftUI

struct SettingsButton: View {
    var imageName: String
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 10) {
                Image(imageName)
                
                Text(title)
                    .foregroundStyle(.black)
                    .font(Fonts.DMSans.regular.swiftUIFont(size: 17))
                    
                Spacer()
                
                Asset.rightArrow.swiftUIImage
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SettingsButton(
        imageName: Asset.faqIcon.name,
        title: "Látogasson el a GYIK oldalra") {}
        .padding()
}
