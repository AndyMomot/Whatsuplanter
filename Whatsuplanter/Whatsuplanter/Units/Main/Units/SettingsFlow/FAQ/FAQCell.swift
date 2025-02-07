//
//  FAQCell.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 07.02.2025.
//

import SwiftUI

struct FAQCell: View {
    let item: FAQView.FAQItem
    @State private var showText = false
    
    var body: some View {
        DashedContainerView {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: .zero) {
                    Text(item.title)
                        .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
                        .foregroundStyle(.black)
                    
                    Spacer(minLength: 8)
                    
                    Button {
                        showText.toggle()
                    } label: {
                        Asset.rightArrow.swiftUIImage
                            .rotationEffect(.degrees(showText ? -90 : 90))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                if showText {
                    Text(item.text)
                        .font(Fonts.DMSans.regular.swiftUIFont(size: 14))
                        .foregroundStyle(.charcoalGray)
                }
            }
        }
        .animation(.bouncy, value: showText)
    }
}

#Preview {
    FAQCell(item: .init(
        title: "Hogyan számíthatom ki a zöldterület kialakításának költségeit?",
        text: "Használhatja a beépített 'Ökológiai költségvetés kalkulátort', hogy megbecsülje a palánták, talaj, felszerelések és egyéb anyagok költségeit. Adja meg a szükséges paramétereket, és a rendszer automatikusan kiszámítja az összeget."))
    .padding()
}
