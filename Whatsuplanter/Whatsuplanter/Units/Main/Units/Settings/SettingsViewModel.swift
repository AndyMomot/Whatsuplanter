//
//  SettingsViewModel.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 05.02.2025.
//

import UIKit.UIImage

extension SettingsView {
    final class ViewModel: ObservableObject {
        @Published var profileImage: UIImage = Asset.profileSample.image
        @Published var userName = ""
        @Published var isCanEdit = false
        @Published var showImagePicker = false
        @Published var isPushNotifications = false
    }
}

extension SettingsView.ViewModel {
    func getUser() async {
        if let user = DefaultsService.shared.user {
            await getProfileImage(for: user.id)
            await MainActor.run { [weak self] in
                self?.userName = user.name
            }
        }
    }
    
    func getProfileImage(for id: String) async {
        if let imageData = await FileManagerService().fetchImage(with: id),
            let uiImage = UIImage(data: imageData) {
            await MainActor.run { [weak self] in
                self?.profileImage = uiImage
            }
        } else {
            await MainActor.run { [weak self] in
                self?.profileImage = Asset.profile.image
            }
        }
    }
    
    func updateUserData() async {
        var user = DefaultsService.shared.user
        user?.name = userName
        
        if let id = user?.id, let imageData = profileImage.jpegData(compressionQuality: 1) {
            FileManagerService().saveImage(data: imageData, for: id)
        }
    }
}
