import Foundation

extension StartCalculationView {
    final class ViewModel: ObservableObject {
        let noCalculationItem: NoFinanceItemsView.Item = .init(
            title: "Üdvözöljük a Környezetvédelmi Költségvetési Kalkulátorban!  ",
            message: "Ez az eszköz segít Önnek kiszámítani környezetvédelmi projektjének költségeit és megtervezni a finanszírozást.",
            rowTitle: "Hogyan működik?",
            rows: [
                .init(id: 1, text: "Adja össze az alapköltségeket"),
                .init(id: 2, text: "Szerezzen be egy előre jelzett mérleget"),
                .init(id: 3, text: "Tippeket kaphat a kiadások optimalizálásához")
            ],
            image: Asset.settings.name)
        
        @Published var showCalculator = false
    }
}
