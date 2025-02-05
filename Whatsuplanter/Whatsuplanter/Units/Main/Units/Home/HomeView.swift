//
//  HomeView.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 04.02.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var tabBarModel: TabBar.ViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.leafGreen.ignoresSafeArea()
                Asset.background.swiftUIImage
                    .resizable()
                
                VStack(spacing: 16) {
                    topBarView
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            goalProgress
                            ecologyView
                            calculationView
                            tipsView
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .scrollIndicators(.automatic)
                }
            }
            .onAppear {
                Task {
                    await viewModel.getUser()
                }
            }
        }
    }
}

private extension HomeView {
    var topBarView: some View {
        HStack(spacing: 16) {
            Image(uiImage: viewModel.profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 42, height: 42)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.white, lineWidth: 1)
                }
            
            Text("Whatsuplanter")
                .foregroundStyle(.white)
                .font(Fonts.DMSans.bold.swiftUIFont(size: 14))
            
            Spacer()
            
            Asset.logo.swiftUIImage
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(.white)
                .scaledToFit()
                .frame(width: 28)
        }
        .padding(.vertical)
        .padding(.horizontal, 25)
        .background(.leafGreen)
        .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
    }
    
    var goalProgress: some View {
        DashedContainerView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Begyűjtendő cél ")
                    .foregroundStyle(.black)
                    .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
                
                if viewModel.user.targetAmount > .zero {
                    VStack(spacing: 0) {
                        ProgressView(value: viewModel.user.currentAmount,
                                     total: viewModel.user.targetAmount)
                        .tint(.leafGreen)
                        
                        HStack {
                            Text("\(Int(viewModel.user.currentAmount))")
                            Spacer()
                            Text("\(Int(viewModel.user.targetAmount))")
                        }
                        .foregroundStyle(.black)
                        .font(Fonts.DMSans.regular.swiftUIFont(size: 12))
                    }
                } else {
                    NextButton(title: "Hozzon létre egy gyűjtési célt") {
                        withAnimation {
                            tabBarModel.selection = .settings
                        }
                    }
                }
            }
        }
    }
    
    var ecologyView: some View {
        DashedContainerView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 8) {
                    Asset.leaf.swiftUIImage
                    Text("Indítsa el saját környezetvédelmi kezdeményezését!")
                        .foregroundStyle(.black)
                        .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
                }
                
                Text("Hozzon létre saját kampányt a zöldítés és a fenntartható fejlődés támogatására. Egyesítse a hasonló gondolkodású embereket, és tegye jobbá a világot!")
                    .foregroundStyle(.charcoalGray)
                    .font(Fonts.DMSans.regular.swiftUIFont(size: 14))
                
                NextButton(title: "Kampány létrehozása") {
                    withAnimation {
                        tabBarModel.selection = .finances
                    }
                }
            }
        }
    }
    
    var calculationView: some View {
        DashedContainerView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top, spacing: 8) {
                    Asset.finaceIcone.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 77)
                    
                    VStack(spacing: 8) {
                        Text("Üdvözöljük a Környezetvédelmi Költségvetési Kalkulátorban!")
                            .foregroundStyle(.black)
                            .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
                        
                        Text("Ez az eszköz segít Önnek kiszámítani környezetvédelmi projektjének költségeit és megtervezni a finanszírozást.")
                            .foregroundStyle(.charcoalGray)
                            .font(Fonts.DMSans.regular.swiftUIFont(size: 14))
                    }
                }
                
                NextButton(title: "Kampány létrehozása") {
                    withAnimation {
                        tabBarModel.selection = .ecoCalculator
                    }
                }
            }
        }
    }
    
    var tipsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                Asset.flower.swiftUIImage
                
                Text("Kertészeti tippek")
                    .foregroundStyle(.black)
                    .font(Fonts.DMSans.bold.swiftUIFont(size: 18))
            }
            
            ForEach(0..<2) { index in
                let tipItem = viewModel.tips[index]
                TipCell(item: tipItem, showButton: false)
            }
            
            NextButton(title: "Tippek olvasása ") {
                withAnimation {
                    tabBarModel.selection = .tips
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
