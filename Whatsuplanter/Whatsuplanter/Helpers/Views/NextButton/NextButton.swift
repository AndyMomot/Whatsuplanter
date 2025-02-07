//
//  NextButton.swift
//
//  Created by Andrii Momot on 08.10.2024.
//

import SwiftUI

struct NextButton: View {
    var title: String
    var imageSystemName: String?
    var titleColors = [Color.white]
    var bgColors: [Color] = [.leafGreen]
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                LinearGradient(
                    colors: bgColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack {
                    Text(title)
                        
                        .font(Fonts.DMSans.bold.swiftUIFont(size: 15))
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.8)
                        .padding(.horizontal, 8)
                    
                    if let imageSystemName {
                        Image(systemName: imageSystemName)
                    }
                        
                }
                .foregroundStyle(LinearGradient(
                    colors: titleColors,
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                
            }
            .frame(height: 56)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ZStack {
        Color.gray
        
        VStack {
            NextButton(title: "Další") {}
                .frame(height: 52)
                .padding(.horizontal)
            
            NextButton(title: "Další",
                       imageSystemName: "arrow.right",
                       titleColors: [.white, .gray],
                       bgColors: [.green, .blue]
            ) {}
                .frame(height: 52)
                .padding(.horizontal)
        }
    }
}
