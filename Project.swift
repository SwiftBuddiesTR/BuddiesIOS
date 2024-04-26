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

let project = Project(
    name: "SwiftBuddiesIOS",
    packages: [
        .remote(url: "https://github.com/google/GoogleSignIn-iOS.git", requirement: .exact("7.0.0")),
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
                .target(aboutModule),
                .target(onboardingModule),
                .target(localizationModule)
//                .target(scriptsModule),
//                .target(localicationCodegen)
            ]
        ),
        authModule,
        feedModule,
        designModule,
        contributorsModule,
        mapModule,
        aboutModule,
        onboardingModule,
//        scriptsModule,
        localizationModule,
        localicationCodegen
    ]
)
