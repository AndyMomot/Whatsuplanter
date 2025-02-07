//
//  FinanceViewModel.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 07.02.2025.
//

import Foundation

extension FinanceView {
    final class ViewModel: ObservableObject {
        @Published var financeItems: [FinanceItem] = []
        @Published var showCreateFinanceItem = false
    }
}

extension FinanceView.ViewModel {
    func getFinanceItems() async {
        let items = DefaultsService.shared.financeItems
        await MainActor.run { [weak self] in
            self?.financeItems = items
        }
    }
}
