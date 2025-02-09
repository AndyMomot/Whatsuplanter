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
        let noFinanceItem: NoFinanceItemsView.Item = .init(
            title: "Hozza létre saját közösségi finanszírozási kampányát",
            message: "Indítson kampányt ökozónája létrehozására. Írja le ötletét, állítsa be a pénzügyi célt, adjon hozzá képeket, és vonja be a támogatókat.",
            rowTitle: "Hogyan működik?",
            rows: [
                .init(id: 1, text: "Írja le a projektjét"),
                .init(id: 2, text: "Állítson be célokat és adjon jutalmakat a támogatóknak"),
                .init(id: 3, text: "Ossza meg a kampányt és gyűjtsön pénzt")
            ],
            image: Asset.finance.name)
    }
}

extension FinanceView.ViewModel {
    func getFinanceItems() async {
        let items = DefaultsService.shared.financeItems
        await MainActor.run { [weak self] in
            self?.financeItems = items
        }
    }
    
    func delete(item: FinanceItem) async {
        DefaultsService.shared.financeItems.removeAll(where: { $0.id == item.id })
        item.images.forEach { id in
            FileManagerService().removeImage(with: id)
        }
        await getFinanceItems()
    }
}
