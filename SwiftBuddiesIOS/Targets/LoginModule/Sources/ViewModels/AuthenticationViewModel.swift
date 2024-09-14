import Foundation
import Combine
import Auth
import Network
import BuddiesNetwork

@MainActor
final class AuthenticationViewModel: ObservableObject {
    private let apiClient: BuddiesClient
    private let authManager: AuthWithSSOProtocol
    
    public init(authManager: AuthWithSSOProtocol = AuthenticationManager.shared) {
        self.authManager = authManager
        self.apiClient = .shared
    }
    
    func signIn(provider: AuthProviderOption) throws {
        Task {
            try await authManager.signIn(provider: provider)
        }
    }
}
