//
//  SettingsView.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 05.02.2025.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.leafGreen.ignoresSafeArea()
                Asset.background.swiftUIImage
                    .resizable()
                
                VStack(spacing: 16) {
                    NavigationBarView(title: "Adatvédelmi irányelvek")
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                Circle()
                                    .frame(width: 40)
                                    .hidden()
                                VStack(spacing: 10) {
                                    Button {
                                        viewModel.showImagePicker.toggle()
                                    } label: {
                                        Image(uiImage: viewModel.profileImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                            .overlay {
                                                Circle()
                                                    .stroke(.leafGreen,
                                                            lineWidth: 2)
                                            }
                                            .padding(.top, 2)
                                    }
                                    .disabled(!viewModel.isCanEdit)
                                    
                                    TextField(text: $viewModel.userName) {
                                        Text("Írja be a becenevét")
                                            .foregroundStyle(.black)
                                            .font(Fonts.DMSans.regular.swiftUIFont(size: 20))
                                    }
                                    .foregroundStyle(.black)
                                    .font(Fonts.DMSans.bold.swiftUIFont(size: 20))
                                    .multilineTextAlignment(.center)
                                    .disabled(!viewModel.isCanEdit)
                                }
                                
                                Button {
                                    if viewModel.isCanEdit {
                                        Task {
                                            await viewModel.updateUserData()
                                        }
                                    }
                                    
                                    withAnimation {
                                        viewModel.isCanEdit.toggle()
                                    }
                                } label: {
                                    Image(systemName: viewModel.isCanEdit ? "checkmark" : "pencil.line")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.white)
                                        .fontWeight(.medium)
                                        .padding(12)
                                        .background(.leafGreen)
                                        .clipShape(Circle())
                                        .frame(width: 40)
                                }
                            }
                            
                            DashedContainerView {
                                VStack(spacing: 20) {
                                    SettingsButton(
                                        imageName: Asset.gardeningTipsIcon.name,
                                        title: "Kertészeti tippek") {
                                            
                                        }
                                    
                                    SettingsButton(
                                        imageName: Asset.dataFillingIcon.name,
                                        title: "Adatok kitöltési folyamata") {
                                            
                                        }
                                    
                                    SettingsButton(
                                        imageName: Asset.faqIcon.name,
                                        title: "Látogasson el a GYIK oldalra") {
                                            
                                        }
                                    
                                    SettingsButton(
                                        imageName: Asset.pprivacyPolicyIcon.name,
                                        title: "Adatvédelmi irányelvek") {
                                            
                                        }
                                }
                            }
                            
                            HStack(spacing: 20) {
                                Text("Push értesítések engedélyezése / kikapcsolása")
                                    .foregroundStyle(.black)
                                    .font(Fonts.DMSans.regular.swiftUIFont(size: 14))
                                
                                Spacer()
                                
                                Toggle("", isOn: $viewModel.isPushNotifications)
                                    .labelsHidden()
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .scrollIndicators(.automatic)
                }
            }
            .onAppear {
                Task {
                    await viewModel.getUser()
                }
            }
            .sheet(isPresented: $viewModel.showImagePicker) {
                ImagePicker(selectedImage: $viewModel.profileImage)
            }
        }
    }
}

#Preview {
    SettingsView()
}
