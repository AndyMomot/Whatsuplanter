//
//  DashedContainerView.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 04.02.2025.
//

import SwiftUI

struct DashedContainerView<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.leafGreen, style: .init(dash: [4, 4]))
        }
        
    }
}

#Preview {
    ZStack {
        Color.gray
        DashedContainerView {
            VStack {
                Asset.logo.swiftUIImage
                Text("Whatsuplanter")
            }
        }
    }
}
