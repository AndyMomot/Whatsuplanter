//
//  View+Additions.swift

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func hideKeyboardWhenTappedAround() -> some View {
        self.onTapGesture {
            self.hideKeyboard()
        }
    }
    
    func share(items: [Any]) {
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            
            // For iPads, you need to set the sourceView and sourceRect for the popover
            if let popoverController = activityController.popoverPresentationController {
                popoverController.sourceView = rootViewController.view // Set to the root view or any view you want to anchor the popover
                popoverController.sourceRect = CGRect(x: rootViewController.view.bounds.midX,
                                                      y: rootViewController.view.bounds.midY,
                                                      width: 0,
                                                      height: 0) // Center of the view
                popoverController.permittedArrowDirections = [] // No arrow needed
            }
            
            rootViewController.present(activityController, animated: true, completion: nil)
        }
    }
    
    // Функція для знімку екрану
    func captureScreenshot() -> UIImage? {
        // Отримуємо доступ до основної сцени
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return nil
        }
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: window.bounds.width, height: window.bounds.height))
        return renderer.image { ctx in
            window.layer.render(in: ctx.cgContext)
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    @ViewBuilder
    func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide {
            self.hidden()
        } else {
            self
        }
    }
}
