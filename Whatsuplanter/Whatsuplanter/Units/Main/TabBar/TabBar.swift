//
//  TabBar.swift

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = ViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Asset.background.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: .zero) {
                TabView(selection: $viewModel.selection) {
                    HomeView()
                        .tag(TabBarSelectionView.home)
                        .environmentObject(viewModel)
                    
                    FinanceView()
                        .tag(TabBarSelectionView.finances)
                        .environmentObject(viewModel)
                    
                    StartCalculationView()
                        .tag(TabBarSelectionView.ecoCalculator)
                        .environmentObject(viewModel)
                    
                    TipsView()
                        .tag(TabBarSelectionView.tips)
                    
                    SettingsView()
                        .tag(TabBarSelectionView.settings)
                        .environmentObject(viewModel)
                }
                
                if viewModel.showTabBar {
                    TabBarCustomView(
                        items: viewModel.items,
                        selectedItem: $viewModel.selection
                    )
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    TabBar()
}
