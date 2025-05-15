//
//  ProjectCreation.swift
//  BuddiesIOSManifests
//
//  Created by Anıl Taşkıran on 15.05.2025.
//

import ProjectDescription

public extension Project {
    static func module(name: String, dependencies: [Module], hasResources: Bool = false) -> Project {
        Project(
            name: name,
            organizationName: "Buddies",
            targets: [
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .staticLibrary,
                    productName: name,
                    bundleId: "com.swiftbuddies.\(name.lowercased())",
                    deploymentTargets: .iOS("17.0"),
                    sources: [
                        "\(name)Module/Sources/**"
                    ],
                    resources: hasResources ? ["Modules/Targets/\(name)Module/Resources/**"] : [],
                    dependencies: dependencies.compactMap({ $0.targetDependency }))
            ]
        )
    }
}
