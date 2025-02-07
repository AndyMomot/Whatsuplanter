import SwiftUI

struct NavigationBarView: View {
    var title: String
    var showBackButton = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack(spacing: 16) {
            
            Button {
                dismiss.callAsFunction()
            } label: {
                Image(systemName: "arrow.left")
                    .foregroundStyle(.leafGreen)
                    .fontWeight(.medium)
                    .padding(8)
                    .background(.white)
                    .clipShape(Circle())
            }
            .buttonStyle(PlainButtonStyle())
            .hidden(!showBackButton)

            Spacer()
            
            Text(title)
                .foregroundStyle(.white)
                .font(Fonts.DMSans.bold.swiftUIFont(size: 14))
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Asset.logo.swiftUIImage
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(.white)
                .scaledToFit()
                .frame(width: 28)
        }
        .padding(.vertical)
        .padding(.horizontal, 25)
        .background(.leafGreen)
        .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
        .navigationBarBackButtonHidden(showBackButton)
    }
}

#Preview {
    ZStack {
        Color.gray
        VStack {
            NavigationBarView(title: "Kertészeti tippek")
            NavigationBarView(title: "Kertészeti tippek",
                              showBackButton: true)
        }
        .padding()
    }
}
