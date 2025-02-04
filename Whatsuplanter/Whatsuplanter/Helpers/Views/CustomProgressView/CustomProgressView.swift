//
//  CustomProgressView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 11.01.2025.
//

import SwiftUI

struct CustomProgressView: View {
    let progress: CGFloat
    var backgroundColor: Color = .white
    var progressColors: [Color] = [.blue, .blue.opacity(0.6)]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 32)
                    .frame(width: geometry.size.width, height: 20)
                    .foregroundColor(backgroundColor)
                
                LinearGradient(
                    colors: progressColors,
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(width: max(0, min((progress * geometry.size.width) - 10, geometry.size.width)))
                .clipShape(RoundedRectangle(cornerRadius: 32))
            }
        }
        .frame(height: 20)
    }
}

#Preview {
    ZStack {
        Color.gray
        CustomProgressView(progress: 0.5)
            .padding()
    }
}

