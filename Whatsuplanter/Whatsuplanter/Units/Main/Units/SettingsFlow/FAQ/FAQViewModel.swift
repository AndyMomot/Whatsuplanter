//
//  FAQViewModel.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 07.02.2025.
//

import Foundation

extension FAQView {
    final class ViewModel: ObservableObject {
        let items: [FAQItem] = [
            .init(title: "Hogyan számíthatom ki a zöldterület kialakításának költségeit?",
                  text: "Használhatja a beépített 'Ökológiai költségvetés kalkulátort', hogy megbecsülje a palánták, talaj, felszerelések és egyéb anyagok költségeit. Adja meg a szükséges paramétereket, és a rendszer automatikusan kiszámítja az összeget."),
            
                .init(title: "Hogyan csökkenthetem a zöldterület kialakításának költségeit?",
                      text: "Használjon újrahasznosított anyagokat, például fa raklapokat virágágyásokhoz, organikus komposztot műtrágya helyett, valamint helyi kezdeményezésektől származó palántákat."),
            
                .init(title: "Kaphatok pénzügyi jelentést a projektről?",
                      text: "Igen, a 'Pénzügyi jelentés' szekcióban megtekintheti az aktuális egyenleget, a kiadásokat és a várható bevételeket."),
        ]
    }
}

extension FAQView {
    struct FAQItem: Identifiable {
        private(set) var id = UUID().uuidString
        var title: String
        var text: String
    }
}
