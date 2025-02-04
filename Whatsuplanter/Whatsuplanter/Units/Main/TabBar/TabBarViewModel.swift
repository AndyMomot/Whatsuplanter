//
//  TabBarViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import Foundation
import SwiftUI

extension TabBar {
    final class ViewModel: ObservableObject {
        @Published var selection = TabBarSelectionView.home
        @Published var showTabBar = true
        
        @Published var items: [TabBar.Item] = [
            .init(imageName: Asset.homeTab.name,
                  title: "Főoldal",
                  tab: .home),
            .init(imageName: Asset.financesTab.name,
                  title: "Pénzügyek",
                  tab: .finances),
            .init(imageName: Asset.calculatorTab.name,
                  title: "Öko-kalkulátor",
                  tab: .ecoCalculator),
            .init(imageName: Asset.tipsTab.name,
                  title: "Tippek",
                  tab: .tips),
            .init(imageName: Asset.settingsTab.name,
                  title: "Beállítások",
                  tab: .settings)
        ]
        
        func showTabBar(_ show: Bool) {
            DispatchQueue.main.async { [weak self] in
                self?.showTabBar = show
            }
        }
    }
}

extension TabBar {
    enum TabBarSelectionView {
        case home
        case finances
        case ecoCalculator
        case tips
        case settings
    }
    
    struct Item: Identifiable {
        private(set) var id = UUID()
        let imageName: String
        let title: String
        let tab: TabBarSelectionView
    }
}
