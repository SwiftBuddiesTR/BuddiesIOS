import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

public enum AuthProviderOption: String {
    case google = "google.com"
    case apple = "apple.com"
}

public enum AuthSSOOption: String {
    case google, apple
}

public final class AuthenticationManager {
    public static let shared = AuthenticationManager()
    private init() { }
    
    public func getAuthenticatedUser() throws -> AuthDataResponse {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResponse(user: user)
    }
        
    public func signOut() throws {
        try Auth.auth().signOut()
    }
    
    public func delete() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        
        try await user.delete()
    }
}

// MARK: SIGN IN SSO

extension AuthenticationManager: AuthWithSSOProtocol {
    
    @discardableResult
    public func signIn(provider: AuthSSOOption) async throws -> AuthDataResponse {        
        let authProvider: AuthProvider = switch provider {
        case .google:
            GoogleAuthenticationProvider()
        case .apple:
            AppleAuthenticationProvider()
        }
        
        let authDataResult = try await Auth.auth().signIn(with: authProvider.credential())
        return AuthDataResponse(user: authDataResult.user)
    }
}
