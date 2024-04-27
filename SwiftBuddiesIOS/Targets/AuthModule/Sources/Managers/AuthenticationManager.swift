import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

public enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
    case apple = "apple.com"
}

public enum AuthSSOOption {
    case google, apple, anonymous
}

public final class AuthenticationManager {
    
    public static let shared = AuthenticationManager()
    private init() { }
    
    public func getAuthenticatedUser() throws -> AuthDataResult {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResult(user: user)
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

// MARK: SIGN IN EMAIL

extension AuthenticationManager: AuthWithEmailProtocol {
    
    @discardableResult
    public func createUser(email: String, password: String) async throws -> AuthDataResult {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResult(user: authDataResult.user)
    }
    
    @discardableResult
    public func signInUser(email: String, password: String) async throws -> AuthDataResult {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResult(user: authDataResult.user)
    }
    
    public func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
}

extension AuthenticationManager {
    
    public func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updatePassword(to: password)
    }
    
}

// MARK: SIGN IN SSO

extension AuthenticationManager: AuthWithSSOProtocol {
    
    @discardableResult
    public func signIn(provider: AuthSSOOption) async throws -> AuthDataResult {
        var authProvider: AuthProvider?
        
        switch provider {
        case .google:
            authProvider = GoogleAuthenticationProvider()
        case .apple:
            authProvider = AppleAuthenticationProvider()
        case .anonymous:
            return try await signInAnonymous()
        }
        
        guard let authProvider else { throw URLError(.badServerResponse) }
        return try await signIn(credential: authProvider.credential())
    }
    
    private func signIn(credential: AuthCredential) async throws -> AuthDataResult {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResult(user: authDataResult.user)
    }
    
    @discardableResult
    private func signInAnonymous() async throws -> AuthDataResult {
        let authDataResult = try await Auth.auth().signInAnonymously()
        return AuthDataResult(user: authDataResult.user)
    }

}
