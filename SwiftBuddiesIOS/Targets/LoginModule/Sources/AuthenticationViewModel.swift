import Foundation
import Auth

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let _ = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
    
    func signInApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let _ = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
    }
    
    func signInAnonymous() async throws {
        let _ = try await AuthenticationManager.shared.signInAnonymous()
    }
    
}
