import ProjectDescription
import Foundation

extension Target {
    static func featureTarget(
        name: String,
        productName: String,
        dependencies: [TargetDependency],
        resources: ResourceFileElements? = nil
    ) -> Self {
         target(
            name: name,
            destinations: .iOS,
            product: .staticLibrary,
            productName: productName,
            bundleId: "com.swiftbuddies.\(productName.lowercased())",
            sources: ["SwiftBuddiesIOS/Targets/\(name)Module/Sources/**"],
            resources: resources,
            dependencies: dependencies)
    }
}

let feedModule = Target.featureTarget(
    name: "Feed",
    productName: "Feed",
    dependencies: []
)

let authModule = Target.featureTarget(
    name: "Auth",
    productName: "Auth",
    dependencies: [.package(product: "GoogleSignIn", type: .runtime, condition: .none)]
)



let project = Project(
    name: "SwiftBuddiesIOS",
    packages: [.remote(url: "https://github.com/google/GoogleSignIn-iOS.git", requirement: .exact("7.0.0"))],
    targets: [
        .target(
            name: "SwiftBuddiesIOS",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.SwiftBuddiesIOS",
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleShortVersionString": "1.0",
                    "CFBundleVersion": "1",
                    "UIMainStoryboardFile": "",
                    "UILaunchStoryboardName": "LaunchScreen",
                    "CLIENT_ID": "221417854896-bs0p0kp2qou67t91g9dtal8pbrv4rki8.apps.googleusercontent.com",
                    "REVERSED_CLIENT_ID": "com.googleusercontent.apps.221417854896-bs0p0kp2qou67t91g9dtal8pbrv4rki8",
                    "CFBundleURLTypes": [
                        ["CFBundleURLSchemes": ["com.googleusercontent.apps.221417854896-bs0p0kp2qou67t91g9dtal8pbrv4rki8"]]
                    ]
                ]
            ),
            sources: ["SwiftBuddiesIOS/Sources/**"],
            resources: ["SwiftBuddiesIOS/Resources/**"],
            dependencies: [
                .package(product: "GoogleSignIn", type: .runtime, condition: .none),
                .target(authModule),
                .target(feedModule)
            ]
        ),
        authModule,
        feedModule
            
    ]
)
