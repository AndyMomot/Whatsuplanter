//
//  NavigationBarView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 12.01.2025.
//

import SwiftUI

struct NavigationBarView: View {
    
    @State private var user: User?
    @State private var image: Image?
    
    var body: some View {
        HStack(spacing: 14) {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 52, height: 52)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.charcoalGray)
                    .padding(8)
                    .clipShape(Circle())
            }
            
            Group {
                Text("Cześć, ")
                    .font(Fonts.DMSans.regular.swiftUIFont(size: 17))
                +
                Text(user?.name ?? "przyjaciel")
                    .font(Fonts.DMSans.bold.swiftUIFont(size: 17))
                
            }
            .foregroundStyle(.white)
            
            Spacer()
        }
        .padding()
        .background(Color.gray)
        .clipShape(Capsule())
        .frame(height: 74)
        .onAppear {
            Task {
                await fetchUser()
            }
        }
    }
}

private extension NavigationBarView {
    func fetchUser() async {
        if let user = DefaultsService.shared.user {
            await fetchImage(for: user.id)
            
            DispatchQueue.main.async {
                self.user = user
            }
        }
    }
    
    func fetchImage(for id: String) async {
        if let imageData = await FileManagerService().fetchImage(with: id),
           let uiImage = UIImage(data: imageData) {
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.gray
        NavigationBarView()
            .padding()
    }
}
