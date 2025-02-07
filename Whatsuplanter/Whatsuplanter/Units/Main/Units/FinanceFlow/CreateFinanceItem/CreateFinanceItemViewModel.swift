//
//  CreateFinanceItemViewModel.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 07.02.2025.
//

import UIKit.UIImage

extension CreateFinanceItemView {
    final class ViewModel: ObservableObject {
        @Published var name: String = ""                { didSet { Task { await validateFields() }}}
        @Published var description: String = ""         { didSet { Task { await validateFields() }}}
        @Published var goalAmount: String = ""          { didSet { Task { await validateFields() }}}
        @Published var durationInDays: String = ""      { didSet { Task { await validateFields() }}}
        @Published var costs: String = ""               { didSet { Task { await validateFields() }}}
        @Published var selectedImages: [UIImage] = []   { didSet { Task { await validateFields() }}}
        @Published var selectedImage = UIImage() {
            didSet {
                if selectedImage != UIImage() {
                    selectedImages.append(selectedImage)
                }
            }
        }
        
        @Published var isValidFields = false
        @Published var showImagePicker = false
    }
}

extension CreateFinanceItemView.ViewModel {
    func validateFields() async {
        let isValid = !name.isEmpty
        && !description.isEmpty
        && Int(goalAmount) ?? .zero > .zero
        && Int(durationInDays) ?? .zero > .zero
        && Int(costs) ?? .zero > .zero
        && !selectedImages.isEmpty
        
        await MainActor.run { [weak self] in
            self?.isValidFields = isValid
        }
    }
    
    func save() async -> Bool {
        guard isValidFields else { return false }
        let imageIds = selectedImages.compactMap { $0.sha256Hash() }
        
        let item = FinanceItem(
            name: name,
            description: description,
            goalAmount: Int(goalAmount) ?? .zero,
            durationInDays: Int(durationInDays) ?? .zero,
            images: imageIds,
            costs: Int(costs) ?? .zero
        )
        
        DefaultsService.shared.financeItems.append(item)
        await saveImages(ids: imageIds, images: selectedImages)
        
        return true
    }
}

private extension CreateFinanceItemView.ViewModel {
    func saveImages(ids: [String], images: [UIImage]) async {
        let fileManager = FileManagerService()
        
        for id in ids {
            if let image = images.first(where: { $0.sha256Hash() == id }),
               let imageData = image.pngData() {
                fileManager.saveImage(data: imageData, for: id)
            }
        }
    }
}
