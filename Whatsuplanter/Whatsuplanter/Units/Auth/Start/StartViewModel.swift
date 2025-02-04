
import Foundation

extension StartView {
    final class ViewModel: ObservableObject {
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://google.com")
    }
}
