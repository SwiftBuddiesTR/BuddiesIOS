import Foundation
import BuddiesNetwork
import Network

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

    public func signOut() throws {
        //signOut
        KeychainManager.shared.delete(.accessToken)
    }
}

// MARK: SIGN IN SSO

public protocol AuthWithSSOProtocol {
    func signIn(provider: AuthProviderOption) async throws
}

extension AuthenticationManager: AuthWithSSOProtocol {
    public func signIn(provider: AuthProviderOption) async throws {
        let authProvider: AuthProvider = switch provider {
        case .google:
            GoogleAuthenticationProvider()
        case .apple:
            AppleAuthenticationProvider()
        }
        
        let credentials = try await authProvider.signIn()
        
        await BuddiesAuthentication.registerUser(signInRequest: credentials)
    }
}

public final class BuddiesAuthentication {
    
    static let apiClient: BuddiesClient = .shared
    
    public static func registerUser(signInRequest: SignInRequest) async {
        let request = RegisterRequest(
            accessToken: signInRequest.accessToken,
            registerType: signInRequest.type
        )
        
        do {
            let data = try await apiClient.perform(request)
            let token = data.token
            let type = data.type 
            KeychainManager.shared.save(key: .accessToken, value: token)
        } catch {
            debugPrint(error)
        }
        // save to keychain
    }
}

struct RegisterRequest: Requestable {
    var accessToken: String
    var registerType: String
    
    struct Data: Decodable {
        let token: String
        let type: String
    }
    
    func toUrlRequest() throws -> URLRequest {
        try URLProvider.returnUrlRequest(
            method: .post,
            url: APIs.Login.register.url(),
            data: self
        )
    }
}
