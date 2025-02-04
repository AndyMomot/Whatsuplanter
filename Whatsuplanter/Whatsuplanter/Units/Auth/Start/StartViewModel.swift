
import Foundation

extension StartView {
    final class ViewModel: ObservableObject {
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://google.com")
        
        func initUser() async {
            let defaultUser = User()
            DefaultsService.shared.user = defaultUser
        }
    }
}
