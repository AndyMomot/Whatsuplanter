//
//  StartView.swift

import SwiftUI

struct StartView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var rootViewModel: RootContentView.ViewModel
    
    var body: some View {
        ZStack {
            Asset.background.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    Asset.logo.swiftUIImage
                        .scaledToFit()
                        .padding(.horizontal, 78)
                    
                    Text("Whatsuplanter")
                        .foregroundStyle(.black)
                        .font(.system(size: 30, weight: .bold))
                }
                
                Asset.onboard4.swiftUIImage
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                VStack(spacing: 16) {
                    NextButton(title: "Folytatás",
                               imageSystemName: "arrow.right") {
                        DispatchQueue.main.async {
                            rootViewModel.setFlow(.main)
                        }
                    }
                    
                    Button {
                        viewModel.showPrivacyPolicy.toggle()
                    } label: {
                        Text("Elfogadom az Adatvédelmi szabályzatot")
                            .foregroundStyle(.black)
                            .font(Fonts.DMSans.regular.swiftUIFont(size: 16))
                            .multilineTextAlignment(.center)
                            .underline()
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.showPrivacyPolicy) {
            SwiftUIViewWebView(url: viewModel.privacyPolicyURL)
        }
    }
}

#Preview {
    StartView()
}
