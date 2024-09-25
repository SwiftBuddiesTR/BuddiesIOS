import SwiftUI
import GoogleSignIn
import Network
import Auth

public protocol DependencyContainerProtocol {
    static var shared: Self { get }

    func get<Product>(
        _ dependencyKey: DependencyKey<Product>
    ) throws -> Product
}

public struct DependencyKey<Product> {
    public let name: String

    init(name: String) {
        self.name = name
    }

    public init(type: Product.Type = Product.self) {
        var name = String(reflecting: type)
//        trimFoundationPrefix(&name)
        self.init(name: name)
    }

    public init(typeOf product: Product) {
        self.init(type: type(of: product))
    }
}

@propertyWrapper public struct Dependency<P> {
    public var wrappedValue: P {
        do {
            return try tryGet()
        } catch {
            assertionFailure(error.localizedDescription)
            preconditionFailure(error.localizedDescription)
        }
    }

    public func tryGet() throws -> P {
        try container().get(key)
    }

    let container: () -> DependencyContainerProtocol
    let key: DependencyKey<P>

    public init<Container: DependencyContainer>(
        container: @autoclosure @escaping () -> DependencyContainerProtocol = DependencyContainer.shared,
        _ keyPath: KeyPath<Container, DependencyKey<P>>
    ) {
        self.container = container
        self.key = DependencyKey<P>()
    }
}

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
    @Dependency(\.authManager) var authManager: AuthenticationManager

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if let clientID = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String {
            let signInConfig = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = signInConfig
        }
        
        dependencyContainer = DependencyContainer.shared
        dependencyContainer.build(launchOptions) {
            KeychainManager.shared.get(key: .accessToken)
        }
        
        try? authManager.signOut()
        
        return true
    }
}

public final class DependencyContainer: DependencyContainerProtocol {
    enum Error: String, LocalizedError {
        case productNotFound
        
        var errorDescription: String { rawValue }
    }
    
    public func get<Product>(_ dependencyKey: DependencyKey<Product>) throws -> Product {
        guard let product = builtDependencies[dependencyKey.name] as? Product else { throw Error.productNotFound }
        return product
    }
    
    public static var shared: DependencyContainer = .init()
    
    let buddiesNetwork = DependencyKey<BuddiesClient>()
    let buddiesAuthenticator = DependencyKey<BuddiesAuthenticationService>()
    let authManager = DependencyKey<AuthenticationManager>()
    
    private init() { }
    
    private var builtDependencies: [String: Any] = [:]
    
    func register<Product>(_ value: Product) {
        let name = String(reflecting: value)
        builtDependencies[name] = value
    }
    
    @MainActor
    func build(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?, accessToken: @escaping (() -> String?)) {
        
        let buddiesInterceptorProvider = BuddiesInterceptorProvider(
            client: .init(
                sessionConfiguration: .default
            ),
            currentToken: accessToken
        )
        register(buddiesInterceptorProvider)
        
        let buddiesChainNetworkTransport = BuddiesRequestChainNetworkTransport.getChainNetworkTransport(
            interceptorProvider: buddiesInterceptorProvider
        )
        register(buddiesChainNetworkTransport)
        
        let buddiesClient = BuddiesClient(
            networkTransporter: buddiesChainNetworkTransport
        )
        register(buddiesClient)
        
        BuddiesClient.shared = buddiesClient
//        self.buddiesNetwork = BuddiesClient.shared
        
        let buddiesAuthService = BuddiesAuthenticationService(
            notificationCenter: .default,
            apiClient: .shared
        )
        register(buddiesAuthService)
        
        BuddiesAuthenticationService.shared = buddiesAuthService
//        self.buddiesAuthenticator = buddiesAuthService
        
        let authenticationManager = AuthenticationManager(authService: BuddiesAuthenticationService.shared)
        AuthenticationManager.shared = authenticationManager
//        self.authManager = authenticationManager
    }
}
