import Foundation
import FirebaseAuth

public protocol AuthProvider {
    func credential() async throws -> AuthCredential
}

public class GoogleAuthenticationProvider: AuthProvider {
    
    public init() { }
    
    public func credential() async throws -> AuthCredential {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        return GoogleAuthProvider.credential(
            withIDToken: tokens.idToken,
            accessToken: tokens.accessToken)
    }
}

public class AppleAuthenticationProvider: AuthProvider {
    
    public init() { }
    
    public func credential() async throws -> AuthCredential {
        let helper = await SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        return OAuthProvider.credential(
            withProviderID: AuthProviderOption.apple.rawValue,
            idToken: tokens.token, 
            rawNonce: tokens.nonce)
    }
}
