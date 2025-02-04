//
//  BackButton.swift
//  Libarorent
//
//  Created by Andrii Momot on 07.10.2024.
//

import SwiftUI

struct BackButton: View {
    var title: String
    var canDismiss = true
    var action: (() -> Void)?
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack(spacing: 18) {
            if canDismiss {
                Button {
                    action?()
                    dismiss.callAsFunction()
                } label: {
                    Image(systemName: "chevron.left")
                        .padding()
                        .background(.gray)
                        .clipShape(Circle())
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            Text(title)
                .lineLimit(2)
                .minimumScaleFactor(0.6)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .foregroundStyle(.white)
        .font(Fonts.DMSans.medium.swiftUIFont(size: 20))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ZStack {
        Color.green
        VStack(spacing: 20) {
            BackButton(title: "Telefony") {}
            BackButton(title: "Telefony") {}
        }
        .padding()
    }
}
