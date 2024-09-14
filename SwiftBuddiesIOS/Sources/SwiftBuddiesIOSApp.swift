import SwiftUI
import GoogleSignIn
import Network

@main
struct SwiftBuddiesIOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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
        dependencyContainer.build(launchOptions)
        return true
    }
}

public class DependencyContainer {
    @MainActor
    func build(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let interceptorProvider: BuddiesInterceptorProvider = BuddiesInterceptorProvider(
            client: .init(
                sessionConfiguration: .default
            )
        )
        
        let buddiesChainNetworkTransport = BuddiesRequestChainNetworkTransport.getChainNetworkTransport(
            interceptorProvider: interceptorProvider
        )
        
        let buddiesClient = BuddiesClient(
            networkTransporter: buddiesChainNetworkTransport
        )
        
        BuddiesClient.shared = buddiesClient
    }
}
