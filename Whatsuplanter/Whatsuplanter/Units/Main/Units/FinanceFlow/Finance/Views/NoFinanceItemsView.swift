//
//  NoFinanceItemsView.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 07.02.2025.
//

import SwiftUI

struct NoFinanceItemsView: View {
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(item.title)
                .foregroundStyle(.black)
                .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
            
            Text(item.message)
                .foregroundStyle(.charcoalBlue)
                .font(Fonts.DMSans.regular.swiftUIFont(size: 14))
            
            VStack(alignment: .leading, spacing: 10) {
                Text(item.rowTitle)
                    .foregroundStyle(.black)
                    .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
                ForEach(item.rows) { item in
                    row(index: item.id, text: item.text)
                }
            }
            
            Spacer()
            
            Image(item.image)
                .resizable()
                .scaledToFit()
            
            Spacer()
        }
    }
}

extension NoFinanceItemsView {
    struct Item {
        var title, message: String
        var rowTitle: String
        var rows: [Row]
        var image: String
    }
    
    struct Row: Identifiable {
        var id: Int
        var text: String
    }
}

private extension NoFinanceItemsView {
    func row(index: Int, text: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Text("\(index)")
                .foregroundStyle(.white)
                .font(Fonts.DMSans.regular.swiftUIFont(size: 14))
                .frame(width: 20, height: 20)
                .background(.leafGreen)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            
            Text(text)
                .foregroundStyle(.charcoalGray)
                .font(Fonts.DMSans.regular.swiftUIFont(size: 14))
        }
    }
}

#Preview {
    NoFinanceItemsView(
        item: .init(title: "Hozza létre saját közösségi finanszírozási kampányát",
                    message: "Indítson kampányt ökozónája létrehozására. Írja le ötletét, állítsa be a pénzügyi célt, adjon hozzá képeket, és vonja be a támogatókat.",
                    rowTitle: "Hogyan működik?",
                    rows: [
                        .init(id: 1, text: "Írja le a projektjét"),
                        .init(id: 2, text: "Állítson be célokat és adjon jutalmakat a támogatóknak"),
                        .init(id: 3, text: "Ossza meg a kampányt és gyűjtsön pénzt")
                    ],
                    image: Asset.finance.name)
    )
        .padding()
}
