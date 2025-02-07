//
//  OnboardingView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import SwiftUI

struct OnboardingView: View {
    var item: OnboardingView.OnboardingItem
    @Binding var currentPageIndex: Int
    
    @EnvironmentObject private var rootViewModel: RootContentView.ViewModel
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Asset.background.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Asset.logo.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48)
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            viewModel.showStartView.toggle()
                        }
                    } label: {
                        Text("Ugrás")
                            .foregroundStyle(.black)
                            .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
                            .padding(4)
                    }
                }
                
                Spacer()
                
                VStack(spacing: 38) {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                    
                    Text(item.text)
                        .foregroundStyle(.charcoalGray)
                        .font(Fonts.DMSans.medium.swiftUIFont(size: 16))
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        withAnimation {
                            currentPageIndex = item.next.rawValue
                        }
                        
                        if item == .third {
                            viewModel.showStartView.toggle()
                        }
                    } label: {
                        CircularProgressBar(
                            progress: item.progress,
                            trackColor: .silverGray,
                            progressColor: .charcoalBlue,
                            lineWidth: 3,
                            lineCap: .round
                        )
                        .frame(width: 92, height: 92)
                        .overlay {
                            Circle()
                                .fill(.leafGreen)
                                .padding(10)
                            
                            Image(systemName: "arrow.right")
                                .foregroundStyle(.white)
                                .fontWeight(.medium)
                        }
                    }

                }
                
            }
            .padding()
        }
        .fullScreenCover(isPresented: $viewModel.showStartView) {
            StartView()
        }
    }
}

#Preview {
    OnboardingView(item: .first, currentPageIndex: .constant(0))
}
