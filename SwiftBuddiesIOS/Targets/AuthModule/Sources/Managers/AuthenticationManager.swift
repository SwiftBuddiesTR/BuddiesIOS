import Foundation

public enum AuthProviderOption: String {
    case google, apple
    
    var domainName: String { self.rawValue + ".com" }
}

public final class AuthenticationManager {
    public static let shared = AuthenticationManager()
    private init() { }
        
//    public func getAuthenticatedUser() {
//        
//    }
//    
    public func signOut() throws {
        //signOut
    }
}

// MARK: SIGN IN SSO

public protocol AuthWithSSOProtocol {
    func signIn(provider: AuthProviderOption) async throws -> SignInRequest
}

extension AuthenticationManager: AuthWithSSOProtocol {
    public func signIn(provider: AuthProviderOption) async throws -> SignInRequest {
        let authProvider: AuthProvider = switch provider {
        case .google:
            GoogleAuthenticationProvider()
        case .apple:
            AppleAuthenticationProvider()
        }
        
        return try await authProvider.signIn()
    }
}
