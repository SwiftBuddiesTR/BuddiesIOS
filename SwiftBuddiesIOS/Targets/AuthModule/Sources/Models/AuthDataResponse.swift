import Foundation
import FirebaseAuth

public struct AuthDataResponse {
    public let uid: String
    public let email: String?
    public let photoUrl: String?
    
    public init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}
