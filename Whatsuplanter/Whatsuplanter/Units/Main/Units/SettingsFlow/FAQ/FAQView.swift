//
//  FAQView.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 07.02.2025.
//

import SwiftUI

struct FAQView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.leafGreen.ignoresSafeArea()
            Asset.background.swiftUIImage
                .resizable()
            
            VStack(spacing: 16) {
                NavigationBarView(title: "FAQ", showBackButton: true)
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.items) { item in
                            FAQCell(item: item)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .scrollIndicators(.never)
            }
            
        }
    }
}

#Preview {
    FAQView()
}
