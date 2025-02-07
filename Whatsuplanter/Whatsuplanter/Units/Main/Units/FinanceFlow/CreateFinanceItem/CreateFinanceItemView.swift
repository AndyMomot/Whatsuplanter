//
//  CreateFinanceItemView.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 07.02.2025.
//

import SwiftUI

struct CreateFinanceItemView: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Color.leafGreen.ignoresSafeArea()
            Asset.background.swiftUIImage
                .resizable()
            
            VStack(spacing: 16) {
                NavigationBarView(title: "Adatok kitöltési folyamata",
                                  showBackButton: true)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Hozza létre saját közösségi finanszírozási kampányát")
                            .foregroundStyle(.black)
                            .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
                        
                        Text("Indítson kampányt ökozónája létrehozására. Írja le ötletét, állítsa be a pénzügyi célt, adjon hozzá képeket, és vonja be a támogatókat.")
                            .foregroundStyle(.charcoalBlue)
                            .font(Fonts.DMSans.regular.swiftUIFont(size: 14))
                        
                        CustomTextField(
                            title: "Kampány neve",
                            placeholder: "Példa: 'Zöld oázis Budapesten'",
                            text: $viewModel.name
                        )
                        
                        CustomTextField(
                            title: "Kampány leírása",
                            placeholder: "min. 150 karakter",
                            isDynamic: true,
                            text: $viewModel.description
                        )
                        
                        CustomTextField(
                            title: "Pénzügyi cél",
                            placeholder: "Példa: 'Zöld oázis Budapesten'",
                            text: $viewModel.goalAmount
                        )
                        .keyboardType(.numberPad)
                        
                        CustomTextField(
                            title: "Kampány időtartama",
                            placeholder: "Példa: 'Zöld oázis Budapesten'",
                            text: $viewModel.durationInDays
                        )
                        .keyboardType(.numberPad)
                        
                        CustomTextField(
                            title: "Költségek",
                            placeholder: "Példa: 'Zöld oázis Budapesten'",
                            text: $viewModel.costs
                        )
                        
                        Text("Fényképek/videók feltöltése")
                            .foregroundStyle(.black)
                            .font(Fonts.DMSans.bold.swiftUIFont(size: 12))
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.selectedImages, id: \.self) { uiImage in
                                    imageButton(uiImage: uiImage)
                                }
                                
                                addImageButton
                            }
                            .frame(height: bounds.width * 0.3)
                            .padding()
                        }
                        .scrollIndicators(.automatic)
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .scrollIndicators(.never)
                
                NextButton(
                    title: "Előnézet megtekintése",
                    imageSystemName: "eye.fill") {
                        Task {
                            if await viewModel.save() {
                                await MainActor.run {
                                    dismiss.callAsFunction()
                                }
                            }
                        }
                    }
                    .padding()
                    .disabled(!viewModel.isValidFields)
            }
        }
        .hideKeyboardWhenTappedAround()
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.selectedImage)
        }
    }
}

private extension CreateFinanceItemView {
    func imageButton(uiImage: UIImage) -> some View {
        Image(uiImage: uiImage)
            .resizable()
            .scaledToFill()
            .frame(width: bounds.width * 0.4,
                   height: bounds.width * 0.3)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                VStack {
                    HStack {
                        Button {
                            withAnimation {
                                viewModel.selectedImages.removeAll(where: {
                                    $0 == uiImage
                                })
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24)
                                .foregroundStyle(.black)
                                .offset(x: -5, y: -5)
                                .shadow(color: .white, radius: 3)
                            
                        }
                        .buttonStyle(PlainButtonStyle())

                        Spacer()
                    }
                    Spacer()
                }
            }
    }
    
    var addImageButton: some View {
        Button {
            viewModel.showImagePicker.toggle()
        } label: {
            Image(systemName: "photo.badge.plus")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(.leafGreen.opacity(0.5))
                .frame(width: bounds.width * 0.4)
                .frame(maxHeight: .infinity)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    CreateFinanceItemView()
}
