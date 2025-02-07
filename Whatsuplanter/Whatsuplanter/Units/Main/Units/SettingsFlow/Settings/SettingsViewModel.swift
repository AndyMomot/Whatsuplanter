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
        
        @Published var currentAmount = "0"
        @Published var targetAmount = "0"
        
        @Published var showTips = false
        @Published var showFAQ = false
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://google.com")
    }
}

extension SettingsView.ViewModel {
    func getUser() async {
        if let user = DefaultsService.shared.user {
            await getProfileImage(for: user.id)
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.userName = user.name
                self.currentAmount = "\(user.currentAmount)"
                self.targetAmount = "\(user.targetAmount)"
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
                self?.profileImage = Asset.profileSample.image
            }
        }
    }
    
    func updateUserData() async {
        let user = User(
            name: userName,
            currentAmount: Int(currentAmount) ?? .zero,
            targetAmount: Int(targetAmount) ?? .zero
        )
        
        DefaultsService.shared.user = user
        
        if let imageData = profileImage.jpegData(compressionQuality: 1) {
            FileManagerService().saveImage(data: imageData, for: user.id)
        }
    }
    
    func checkNotificationPermission() async -> Bool {
        let permission = await NotificationManager.shared.checkPermission()
        var isGranted: Bool {
            switch permission {
            case .authorized, .provisional:
                return true
            default:
                return false
            }
        }
        
        return isGranted
    }
    
    func updateToggle() async {
        let isGranted = await checkNotificationPermission()
        await MainActor.run { [weak self] in
            guard let self else { return }
            self.isPushNotifications = isGranted
        }
    }
    
    func onToggle() async {
        do {
            let granted = try await NotificationManager.shared.requestPermission()
            if !granted {
                NotificationManager.shared.openNotificationSettings()
            } else {
                await updateToggle()
            }
        } catch {
            NotificationManager.shared.openNotificationSettings()
        }
    }
}
