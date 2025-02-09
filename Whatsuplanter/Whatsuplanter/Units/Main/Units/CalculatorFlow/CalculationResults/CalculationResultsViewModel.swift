//
//  CalculationResultsViewModel.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 09.02.2025.
//

import Foundation
import UIKit.UIImage

extension CalculationResultsView {
    final class ViewModel: ObservableObject {
        @Published var user = User()
    }
}

extension CalculationResultsView.ViewModel {
    func getUser() async {
        if let user = DefaultsService.shared.user {
            await MainActor.run { [weak self] in
                self?.user = user
            }
        }
    }
}
