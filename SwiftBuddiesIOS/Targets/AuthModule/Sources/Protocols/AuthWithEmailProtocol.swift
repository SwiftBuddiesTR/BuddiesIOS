import Foundation

public protocol AuthWithEmailProtocol {
    func createUser(email: String, password: String) async throws -> AuthDataResult
    func signInUser(email: String, password: String) async throws -> AuthDataResult
    func resetPassword(email: String) async throws
}
