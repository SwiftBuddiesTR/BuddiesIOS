import ProjectDescription
import Foundation

extension Target {
    static func featureTarget(
        name: String,
        productName: String,
        dependencies: [TargetDependency],
        hasResources: Bool = false
    ) -> Self {
         target(
            name: name,
            destinations: .iOS,
            product: .staticLibrary,
            productName: productName,
            bundleId: "com.swiftbuddies.\(productName.lowercased())",
            sources: ["SwiftBuddiesIOS/Targets/\(name)Module/Sources/**"],
            resources: hasResources ? ["SwiftBuddiesIOS/Targets/\(name)Module/Resources/**"] : [],
            dependencies: dependencies)
    }
}

let designModule = Target.featureTarget(
    name: "Design",
    productName: "Design",
    dependencies: [],
    hasResources: true
)


let feedModule = Target.featureTarget(
    name: "Feed",
    productName: "Feed",
    dependencies: [.target(designModule)]
)

let aboutModule = Target.featureTarget(
    name: "About",
    productName: "About",
    dependencies: [.target(designModule)]
)

let contributorsModule = Target.featureTarget(
    name: "Contributors",
    productName: "Contributors",
    dependencies: [.target(designModule)]
)

let mapModule = Target.featureTarget(
    name: "Map",
    productName: "Map",
    dependencies: [.target(designModule)]
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
                .target(feedModule),
                .target(designModule),
                .target(contributorsModule),
                .target(mapModule),
                .target(aboutModule)
            ]
        ),
        authModule,
        feedModule,
        designModule,
        contributorsModule,
        mapModule,
        aboutModule
    ]
)
