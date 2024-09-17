import SwiftUI
import GoogleSignIn
import Network
import Auth

@main
struct SwiftBuddiesIOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    init() {
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencyContainer: DependencyContainer!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if let clientID = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String {
            let signInConfig = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = signInConfig
        }
        
        dependencyContainer = DependencyContainer()
        dependencyContainer.build(launchOptions) {
            KeychainManager.shared.get(key: .accessToken)
        }
        return true
    }
}

public class DependencyContainer: ObservableObject {
    
    var buddiesNetwork: BuddiesClient!
    
    @MainActor
    func build(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?, accessToken: @escaping (() -> String?)) {
        let buddiesInterceptorProvider = BuddiesInterceptorProvider(
            client: .init(
                sessionConfiguration: .default
            ),
            currentToken: accessToken
        )
        
        let buddiesChainNetworkTransport = BuddiesRequestChainNetworkTransport.getChainNetworkTransport(
            interceptorProvider: buddiesInterceptorProvider
        )
        
        let buddiesClient = BuddiesClient(
            networkTransporter: buddiesChainNetworkTransport
        )
        
        BuddiesClient.shared = buddiesClient
        self.buddiesNetwork = BuddiesClient.shared
    }
}
