//
//  TipsView.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 04.02.2025.
//

import SwiftUI

struct TipsView: View {
    var showBackButton = false
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.leafGreen.ignoresSafeArea()
                Asset.background.swiftUIImage
                    .resizable()
                
                VStack(spacing: 16) {
                    NavigationBarView(title: "Kertészeti tippek",
                                      showBackButton: showBackButton)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.tips) { tip in
                                TipCell(item: tip)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .scrollIndicators(.automatic)
                }
            }
        }
    }
}

#Preview {
    TipsView()
}
