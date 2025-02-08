//
//  NoFinanceItemsView.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 07.02.2025.
//

import SwiftUI

struct NoFinanceItemsView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Hozza létre saját közösségi finanszírozási kampányát")
                .foregroundStyle(.black)
                .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
            
            Text("Indítson kampányt ökozónája létrehozására. Írja le ötletét, állítsa be a pénzügyi célt, adjon hozzá képeket, és vonja be a támogatókat.")
                .foregroundStyle(.charcoalBlue)
                .font(Fonts.DMSans.regular.swiftUIFont(size: 14))
            
            VStack(alignment: .leading, spacing: 10) {
                row(index: 1, text: "Írja le a projektjét")
                row(index: 2, text: "Állítson be célokat és adjon jutalmakat a támogatóknak")
                row(index: 3, text: "Ossza meg a kampányt és gyűjtsön pénzt")
            }
            
            Spacer()
            
            Asset.finance.swiftUIImage
                .resizable()
                .scaledToFit()
            
            Spacer()
        }
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
    NoFinanceItemsView()
        .padding()
}
