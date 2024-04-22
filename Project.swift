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

let localizationModule = Target.featureTarget(
    name: "Localization",
    productName: "Localization",
    dependencies: [],
    hasResources: true
)

let designModule = Target.featureTarget(
    name: "Design",
    productName: "Design",
    dependencies: [.target(localizationModule)],
    hasResources: true
)

let authModule = Target.featureTarget(
    name: "Auth",
    productName: "Auth",
    dependencies: [
        .package(product: "GoogleSignIn", type: .runtime, condition: .none),
        .package(product: "FirebaseAuth", type: .runtime, condition: .none)
    ]
)

let onboardingModule = Target.featureTarget(
    name: "Onboarding",
    productName: "Onboarding",
    dependencies: [.target(designModule)]
)

let localicationCodegen = Target.target(
    name: "LocalizationCodegen",
    destinations: .macOS,
    product: .commandLineTool,
    productName: "LocalizationCodegen",
    bundleId: "com.swiftbuddies.localization",
    sources: ["SwiftBuddiesIOS/Targets/ScriptsModule/LocalizationCodegen/**"],
    scripts: [],
    dependencies: [.package(product: "ArgumentParser", type: .runtime, condition: .none)],
    coreDataModels: [],
    environmentVariables: [:],
    launchArguments: [],
    additionalFiles: [],
    buildRules: [],
    mergedBinaryType: .automatic,
    mergeable: false
)



//let scriptsModule = Target.target(
//    name: "Scripts",
//    destinations: .macOS,
//    product: .staticFramework,
//    productName: "Scripts",
//    bundleId: "com.swiftbuddies.scripts",
//    deploymentTargets: nil,
//    infoPlist: nil,
//    
//    sources: ["SwiftBuddiesIOS/Targets/ScriptsModule/**"],
//    resources: nil,
//    copyFiles: nil,
//    headers: nil,
//    entitlements: nil,
//    scripts: [],
//    dependencies: [.target(localicationCodegen)],
//    settings: nil,
//    coreDataModels: [],
//    environmentVariables: [:],
//    launchArguments: [],
//    additionalFiles: [],
//    buildRules: [],
//    mergedBinaryType: .automatic,
//    mergeable: false
//)
let loginModule = Target.featureTarget(
    name: "Login",
    productName: "Login",
    dependencies: [
        .target(designModule),
        .target(authModule),
        .package(product: "GoogleSignIn", type: .runtime, condition: .none),
        .package(product: "FirebaseAuth", type: .runtime, condition: .none)
    ]
)

let feedModule = Target.featureTarget(
    name: "Feed",
    productName: "Feed",
    dependencies: [.target(designModule)]
)

let mapModule = Target.featureTarget(
    name: "Map",
    productName: "Map",
    dependencies: [.target(designModule)]
)

let profileModule = Target.featureTarget(
    name: "Profile",
    productName: "Profile",
    dependencies: [
        .target(designModule),
        .target(authModule),
        .package(product: "GoogleSignIn", type: .runtime, condition: .none),
        .package(product: "FirebaseAuth", type: .runtime, condition: .none)
    ]
)

let contributorsModule = Target.featureTarget(
    name: "Contributors",
    productName: "Contributors",
    dependencies: [.target(designModule)]
)


let project = Project(
    name: "Buddies",
    packages: [
        .remote(url: "https://github.com/google/GoogleSignIn-iOS.git", requirement: .exact("7.0.0")),
        .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .exact("10.24.0")),
        .remote(url: "https://github.com/apple/swift-argument-parser.git", requirement: .exact("1.3.0"))
    ],
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
                    "CLIENT_ID": "1015261010783-dq3s025o2j6pcj81ped6nqpbiv5m1fvr.apps.googleusercontent.com",
                    "REVERSED_CLIENT_ID": "com.googleusercontent.apps.1015261010783-dq3s025o2j6pcj81ped6nqpbiv5m1fvr",
                    "CFBundleURLTypes": [
                        ["CFBundleURLSchemes": ["com.googleusercontent.apps.1015261010783-dq3s025o2j6pcj81ped6nqpbiv5m1fvr"]]
                    ]
                ]
            ),
            sources: ["SwiftBuddiesIOS/Sources/**"],
            resources: ["SwiftBuddiesIOS/Resources/**"],
            dependencies: [
                .package(product: "GoogleSignIn", type: .runtime, condition: .none),
                .package(product: "FirebaseAuth", type: .runtime, condition: .none),
                .target(designModule),
                .target(authModule),
                .target(onboardingModule),
                .target(loginModule),
                .target(feedModule),
                .target(mapModule),
                .target(profileModule),
                .target(contributorsModule),
//                .target(scriptsModule),
//                .target(localicationCodegen)
                .target(localizationModule)
            ]
        ),
        designModule,
        authModule,
        onboardingModule,
        loginModule,
        feedModule,
        mapModule,
        profileModule,
        contributorsModule,
//        scriptsModule,
        localizationModule,
        localicationCodegen
    ]
)
