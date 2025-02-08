//
//  UIImage+Additions.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 07.02.2025.
//

import UIKit.UIImage
import CryptoKit

extension UIImage {
    func sha256Hash(appending: String? = nil) -> String? {
        guard let imageData = self.pngData() else { return nil }
        let hash = SHA256.hash(data: imageData)
        var id = hash.compactMap { String(format: "%02x", $0) }.joined()
        if let appending { id.append(appending) }
        return id
    }
}
