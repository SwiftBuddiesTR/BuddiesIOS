import Foundation
import Auth

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    private let authManager: AuthWithSSOProtocol
    
    init(authManager: AuthWithSSOProtocol = AuthenticationManager.shared) {
        self.authManager = authManager
    }
    
    func signIn(provider: AuthSSOOption) async throws {
        let _ = try await authManager.signIn(provider: provider)
    }
    
}
