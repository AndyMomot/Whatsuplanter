//
//  TabBarCustomView.swift

import SwiftUI

struct TabBarCustomView: View {
    
    let items: [TabBar.Item]
    @Binding var selectedItem: TabBar.TabBarSelectionView
    
    private var arrange: [Int] {
        Array(0..<items.count)
    }
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(items) { item in
                let isSelected = selectedItem == item.tab
                
                Button {
                    DispatchQueue.main.async {
                        withAnimation {
                            selectedItem = item.tab
                        }
                    }
                } label: {
                    VStack(spacing: 8) {
                        Image(item.imageName)
                            .renderingMode(.template)
                            .foregroundStyle(isSelected ? .charcoalGray : .white)
                        
                        Text(item.title)
                            .foregroundStyle(isSelected ? .charcoalGray : .white)
                            .font(Fonts.DMSans.regular.swiftUIFont(size: 10))
                            .multilineTextAlignment(.center)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .padding(.bottom, 40)
        .background(.leafGreen)
        .cornerRadius(16, corners: [.topLeft, .topRight])
        
    }
}

#Preview {
    VStack {
        Spacer()
        TabBarCustomView(items: [
            .init(imageName: Asset.homeTab.name,
                  title: "Főoldal",
                  tab: .home),
            .init(imageName: Asset.financesTab.name,
                  title: "Pénzügyek",
                  tab: .finances),
            .init(imageName: Asset.calculatorTab.name,
                  title: "Öko-kalkulátor",
                  tab: .ecoCalculator),
            .init(imageName: Asset.tipsTab.name,
                  title: "Tippek",
                  tab: .tips),
            .init(imageName: Asset.settingsTab.name,
                  title: "Beállítások",
                  tab: .settings)
        ], selectedItem: .constant(.home))
    }
}
