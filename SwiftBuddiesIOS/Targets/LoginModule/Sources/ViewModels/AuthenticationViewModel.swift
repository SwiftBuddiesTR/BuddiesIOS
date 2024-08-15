import Foundation
import Combine
import Auth
import Network

@MainActor
final class AuthenticationViewModel: ObservableObject {
    @Published public private(set) var userInfo: SignInResponse?
    
    private let authManager: AuthWithSSOProtocol
    private let loginDataService = LoginDataService()
    private var cancellables = Set<AnyCancellable>()
    
    public init(authManager: AuthWithSSOProtocol = AuthenticationManager.shared) {
        self.authManager = authManager
        addSubscribers()
    }
    
    private func addSubscribers() {
        loginDataService.$userInfo
            .sink { [weak self] userInfo in
                self?.userInfo = userInfo
            }
            .store(in: &cancellables)
    }
    
    func signIn(provider: AuthProviderOption) {
        Task {
            try await signIn(provider: provider)
        }
    }
    
    private func signIn(provider: AuthProviderOption) async throws {
        let signInRequest = try await authManager.signIn(provider: provider)
        loginDataService.loginRequest(with: signInRequest)
    }
}
