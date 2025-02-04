//
//  TipCell.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 04.02.2025.
//

import SwiftUI

struct TipCell: View {
    let item: TipsView.TipModel
    var showButton = true
    
    @State private var showText = false
    
    var body: some View {
        DashedContainerView {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Text(item.title)
                        .foregroundStyle(.black)
                        .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
                    
                    Spacer()
                    
                    if showButton {
                        Button {
                            withAnimation {
                                showText.toggle()
                            }
                        } label: {
                            Image(systemName: showText ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.steelGray)
                                .frame(width: 24, height: 24)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                if showText {
                    Text(item.text)
                        .foregroundStyle(.charcoalGray)
                        .font(Fonts.DMSans.regular.swiftUIFont(size: 14))
                    
                }
            }
        }
    }
}

#Preview {
    TipCell(item:  .init(
        title: "Hogyan válasszunk növényeket városi környezetbe?",
        text: """
                         Válasszon olyan növényeket, amelyek kevésbé igényesek a talajra és az árnyékra, például levendulát, árnyékliliomot, borostyánt vagy muskátlit.
                         
                         Ezek jól alkalmazkodnak a szennyezett levegőhöz és a korlátozott térhez.
                         
                         A rendszeres öntözés és mulcsozás segít megőrizni a nedvességet.
                         """)
    )
    .padding()
}
