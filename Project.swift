import ProjectDescription
import Foundation
import ProjectDescriptionHelpers

let project = Project(
    name: "Buddies",
    targets: [
        .target(
            name: "SwiftBuddiesIOS",
            destinations: .iOS,
            product: .app,
            bundleId: "com.dogukaank.SwiftBuddiesIOS",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleShortVersionString": "0.0.1",
                    "CFBundleVersion": "1",
                    "UIMainStoryboardFile": "",
                    "UILaunchStoryboardName": "LaunchScreen",
                    "CLIENT_ID": "1015261010783-dq3s025o2j6pcj81ped6nqpbiv5m1fvr.apps.googleusercontent.com",
                    "REVERSED_CLIENT_ID": "com.googleusercontent.apps.1015261010783-dq3s025o2j6pcj81ped6nqpbiv5m1fvr",
                    "NSLocationWhenInUseUsageDescription": "Your location is needed to provide location-based features.",
                    "NSCameraUsageDescription": "Camera is needed to take photos.",
                    "CFBundleURLTypes": [
                        ["CFBundleURLSchemes": ["com.googleusercontent.apps.1015261010783-dq3s025o2j6pcj81ped6nqpbiv5m1fvr"]]
                    ],
                    "ITSAppUsesNonExemptEncryption": false
                ]
            ),
            sources: ["SwiftBuddiesIOS/Sources/**"],
            resources: ["SwiftBuddiesIOS/Resources/**"],
            entitlements: .dictionary(
                [
                    "com.apple.developer.applesignin" : ["Default"],
                    "com.apple.developer.authentication-services.autofill-credential-provider": true
                ]
            ),
            dependencies: [
                .external(name: "GoogleSignIn"),
                .external(name: "BuddiesNetwork"),
                .target(Module.design.target),
                .target(Module.auth.target),
                .target(Module.login.target),
                .target(Module.onboarding.target),
                .target(Module.feed.target),
                .target(Module.map.target),
                .target(Module.profile.target),
                .target(Module.contributors.target),
                .target(Module.localization.target),
                .target(Module.core.target),
                Module.network.targetDependency,
            ]
        ),
        Module.design.target,
        Module.auth.target,
        Module.onboarding.target,
        Module.login.target,
        Module.feed.target,
        Module.map.target,
        Module.profile.target,
        Module.contributors.target,
        Module.localization.target,
        Module.core.target,
        Module.localicationCodegen,
        Module.colorPaletteCodegen
    ]
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
