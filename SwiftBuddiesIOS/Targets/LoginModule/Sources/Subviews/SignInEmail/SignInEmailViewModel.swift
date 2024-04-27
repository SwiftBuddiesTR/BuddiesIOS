import Foundation
import Auth

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var visible: Bool = false
    
    private let authManager: AuthWithEmailProtocol
    
    init(authManager: AuthWithEmailProtocol = AuthenticationManager.shared) {
        self.authManager = authManager
    }
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            debugPrint("No email or password found.")
            return
        }
        
        let _ = try await authManager.createUser(email: email, password: password)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            debugPrint("No email or password found.")
            return
        }
        
        let _ = try await authManager.signInUser(email: email, password: password)
    }
    
    func forgotPassword() async throws {
        guard !email.isEmpty else {
            debugPrint("No email found.")
            return
        }
        
        try await authManager.resetPassword(email: email)
    }
}
