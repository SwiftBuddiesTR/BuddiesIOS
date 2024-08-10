import Foundation
import Auth
import Network

@MainActor
final class AuthenticationViewModel: ObservableObject {
    private let authManager: AuthWithSSOProtocol
    
    init(authManager: AuthWithSSOProtocol = AuthenticationManager.shared) {
        self.authManager = authManager
    }
    
    func signIn(provider: AuthSSOOption) async throws {
        let authData = try await authManager.signIn(provider: provider)
        NetworkManager.shared.loginRequest(registerType: provider, accessToken: authData.uid) { response in
            switch response {
            case .success(let success):
                debugPrint(success.type)
                debugPrint(success.token)
            case .failure(let failure):
                debugPrint(failure.localizedDescription)
            }
        }
    }
}
