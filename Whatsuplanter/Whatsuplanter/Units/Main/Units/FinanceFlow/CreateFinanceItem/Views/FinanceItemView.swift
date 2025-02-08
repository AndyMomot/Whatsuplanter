//
//  FinanceItemView.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 08.02.2025.
//

import SwiftUI

struct FinanceItemView: View {
    var item: FinanceItem
    var isPreview: Bool = false
    @State var savedImages: [UIImage] = []
    var action: (ViewAction) -> Void
    
    @State private var showAll = false
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        VStack {
            DashedContainerView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 16) {
                        Text(item.name)
                            .foregroundStyle(.black)
                            .font(Fonts.DMSans.bold.swiftUIFont(size: 16))
                        
                        Spacer()
                        
                        Button {
                            showAll.toggle()
                        } label: {
                            Asset.rightArrow.swiftUIImage
                                .rotationEffect(.degrees(showAll ? -90 : 90))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        createInfoRow(
                            image: Asset.targetAmount.name,
                            title: "Célösszeg: ",
                            text: Double(item.goalAmount).string(usesSeparator: true)
                        )
                        
                        createInfoRow(
                            image: Asset.calendar.name,
                            title: "Időtartam: ",
                            text: "\(item.durationInDays) nap"
                        )
                        
                        createInfoRow(
                            image: Asset.costs.name,
                            title: "Költségek: ",
                            text: Double(item.costs).string(usesSeparator: true)
                        )
                        
                        createInfoRow(
                            image: Asset.description.name,
                            title: "Leírás: ",
                            text: item.description
                        )
                    }
                    .padding(.leading)
                    
                    if showAll {
                        if !savedImages.isEmpty {
                            ScrollView(.horizontal) {
                                HStack(spacing: 16) {
                                    ForEach(savedImages, id: \.self) { image in
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: bounds.width * 0.4,
                                                   height: bounds.width * 0.3)
                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                            .shadow(radius: 1)
                                    }
                                }
                                .frame(height: bounds.width * 0.3)
                                .padding()
                            }
                            .scrollIndicators(.automatic)
                        }
                        
                        NextButton(
                            title: isPreview ? "Közzététel" : "Töröl",
                            imageSystemName: isPreview ? "paperplane.fill" : "trash") {
                                action(isPreview ? .save : .delete)
                            }
                    }
                }
            }
            Spacer()
        }
        .animation(.bouncy, value: showAll)
        .onAppear {
            showAll = isPreview
            Task {
                if !isPreview {
                    await getImages()
                }
            }
        }
    }
}

extension FinanceItemView {
    enum ViewAction {
        case save
        case delete
    }
}

private extension FinanceItemView {
    func createInfoRow(image: String, title: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(image)
            
            Text(title)
                .foregroundColor(.black)
                .font(Fonts.DMSans.bold.swiftUIFont(size: 14))
            +
            Text(text)
                .foregroundColor(.charcoalGray)
                .font(Fonts.DMSans.regular.swiftUIFont(size: 14))
        }
    }
    
    func getImages() async {
        var images: [UIImage] = []
        
        for id in item.images {
            if let image = await getImage(for: id) {
                images.append(image)
            }
        }
        
        await MainActor.run {
            self.savedImages = images
        }
    }
    
    func getImage(for id: String) async -> UIImage? {
        guard let imageData = await FileManagerService().fetchImage(with: id),
                let uiImage = UIImage(data: imageData) else {
            return nil
        }
        
        return uiImage
    }
}

#Preview {
    FinanceItemView(
        item: .init(
            name: "Name",
            description: "Descriptio",
            goalAmount: 1_000_000,
            durationInDays: 50,
            images: ["1", "2"],
            costs: 500_00),
        isPreview: true
    ) {_ in}
    .padding()
}
