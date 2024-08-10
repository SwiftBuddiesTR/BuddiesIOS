import Foundation

public protocol AuthWithSSOProtocol {
    func signIn(provider: AuthSSOOption) async throws -> AuthDataResponse
}
