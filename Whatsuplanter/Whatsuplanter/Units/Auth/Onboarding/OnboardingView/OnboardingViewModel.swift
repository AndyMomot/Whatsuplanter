//
//  OnboardingViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {
        @Published var showStartView = false
    }
    
    enum OnboardingItem: Int, CaseIterable {
        case first = 0
        case second
        case third
        
        var image: String {
            switch self {
            case .first:
                return Asset.onboard1.name
            case .second:
                return Asset.onboard2.name
            case .third:
                return Asset.onboard3.name
            }
        }
        
        var text: String {
            switch self {
            case .first:
                return "Üdvözlünk a Whatsuplanterben! Együtt alakíthatjuk át az öko-barát elképzeléseket virágzó zöld övezetté."
            case .second:
                return "Egyszerűen kezelheted a közösségi finanszírozási kampányokat, és nyomon követheted öko-projekted minden lépését. A finanszírozástól a megvalósításig mindent rendszerezetten tarthats"
            case .third:
                return "Az ötleteid formálhatják a zöldebb jövőt. Indítsd el kampányodat még ma, és inspirálj másokat is a tartós változásra!"
            }
        }

        var next: Self {
            switch self {
            case .first:
                return .second
            case .second, .third:
                return .third
            }
        }
        
        var lastIndex: Int {
            OnboardingItem.allCases.last?.rawValue ?? .zero
        }
        
        var progress: Double {
            Double(rawValue + 1) / Double(lastIndex + 1)
        }
    }
}
