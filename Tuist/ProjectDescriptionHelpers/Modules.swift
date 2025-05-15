//
//  Module.swift
//  ProjectDescriptionHelpers
//
//  Created by Anıl Taşkıran on 15.05.2025.
//

import ProjectDescription

public let networkModule = TargetDependency.project(target: "Network",
                                                    path: .relativeToRoot("Modules/NetworkModule"))


public enum Module: String, CaseIterable {
    case core
    case localization
    case design
    case network
    case auth
    case onboarding
    case login
    case feed
    case map
    case profile
    case contributors
    case googleSignIn = "GoogleSignIn"
    case buddiesNetwork = "BuddiesNetwork"

    public var targetDependency: TargetDependency {
        if self == .network {
            return networkModule
        }
        if self == .googleSignIn || self == .buddiesNetwork {
            return .external(name: self.rawValue)
        }

        return .target(target)
    }

    public var target: Target {
        switch self {
        case .core:
            Target.featureTarget(
                name: "Core",
                productName: "Core",
                dependencies:
                    [.auth,
                     .network,
                     .googleSignIn
                     ]
            )
        case .localization:
            Target.featureTarget(
                name: "Localization",
                productName: "Localization",
                dependencies: [],
                hasResources: true
            )
        case .design:
            Target.featureTarget(
                name: "Design",
                productName: "Design",
                dependencies: [.localization],
                hasResources: true
            )
        case .network:
            Target.featureTarget(
                name: "Network",
                productName: "Network",
                dependencies: [
                    .buddiesNetwork
                ]
            )
        case .auth:
            Target.featureTarget(
                name: "Auth",
                productName: "Auth",
                dependencies: [
                    .network,
                    .googleSignIn,
                ]
            )
        case .onboarding:
            Target.featureTarget(
                name: "Onboarding",
                productName: "Onboarding",
                dependencies: [
                    .design,
                    .core,
                ]
            )
        case .login:
            Target.featureTarget(
                name: "Login",
                productName: "Login",
                dependencies: [
                    .design,
                    .auth,
                    .network,
                    .core,
                    .googleSignIn,
                ]
            )
        case .feed:
            Target.featureTarget(
                name: "Feed",
                productName: "Feed",
                dependencies: [
                    .core,
                    .design,
                    .googleSignIn,
                ]
            )
        case .map:
            Target.featureTarget(
                name: "Map",
                productName: "Map",
                dependencies: [
                    .core,
                    .design
                ]
            )
        case .profile:
            Target.featureTarget(
                name: "Profile",
                productName: "Profile",
                dependencies: [
                    .design,
                    .auth,
                    .network,
                    .core,
                    .googleSignIn,
                ]
            )
        case .contributors:
            Target.featureTarget(
                name: "Contributors",
                productName: "Contributors",
                dependencies: [
                    .core,
                    .design
                ]
            )
        case .googleSignIn, .buddiesNetwork:
            Target.featureTarget(
            name: "",
            productName: "",
            dependencies: []
        )
        }
    }
}
