
import Foundation
import GoogleSignIn

final public class Authenticator {
    
    private init() {
        GIDSignIn.sharedInstance.configuration = .init(clientID: "221417854896-bs0p0kp2qou67t91g9dtal8pbrv4rki8.apps.googleusercontent.com")
        self.googleService = GIDSignIn.sharedInstance
    }
    public static let shared = Authenticator()
    
    private let googleService: GIDSignIn
    
    @MainActor
    public func signIn() async throws {
        guard let vc = UIApplication.shared.windows.first?.rootViewController else { return }
        
        let credentials = try await googleService.signIn(withPresenting: vc)
        dump(credentials)
    }
    
}
