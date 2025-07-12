//
//  Module.swift
//  ProjectDescriptionHelpers
//
//  Created by Anıl Taşkıran on 15.05.2025.
//

import ProjectDescription

public let networkModule = TargetDependency.project(target: "Network",
                                                    path: .relativeToRoot("Modules/NetworkModule"))

public let coreModule = TargetDependency.project(target: "Core",
                                               path: .relativeToRoot("Modules/CoreModule"))

public let localizationModule = TargetDependency.project(target: "Localization",
                                                       path: .relativeToRoot("Modules/LocalizationModule"))

public let designModule = TargetDependency.project(target: "Design",
                                                 path: .relativeToRoot("Modules/DesignModule"))

public let authModule = TargetDependency.project(target: "Auth",
                                               path: .relativeToRoot("Modules/AuthModule"))

public let onboardingModule = TargetDependency.project(target: "Onboarding",
                                                     path: .relativeToRoot("Modules/OnboardingModule"))

public let loginModule = TargetDependency.project(target: "Login",
                                                path: .relativeToRoot("Modules/LoginModule"))

public let feedModule = TargetDependency.project(target: "Feed",
                                               path: .relativeToRoot("Modules/FeedModule"))

public let mapModule = TargetDependency.project(target: "Map",
                                              path: .relativeToRoot("Modules/MapModule"))

public let profileModule = TargetDependency.project(target: "Profile",
                                                  path: .relativeToRoot("Modules/ProfileModule"))

public let contributorsModule = TargetDependency.project(target: "Contributors",
                                                       path: .relativeToRoot("Modules/ContributorsModule"))

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
        switch self {
        case .network:
            return networkModule
        case .core:
            return coreModule
        case .localization:
            return localizationModule
        case .design:
            return designModule
        case .auth:
            return authModule
        case .onboarding:
            return onboardingModule
        case .login:
            return loginModule
        case .feed:
            return feedModule
        case .map:
            return mapModule
        case .profile:
            return profileModule
        case .contributors:
            return contributorsModule
        case .googleSignIn, .buddiesNetwork:
            return .external(name: self.rawValue)
        }
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
