//
//  ProjectCreation.swift
//  Packages
//
//  Created by Anıl Taşkıran on 15.05.2025.
//

import ProjectDescription

public extension Target {
    static func featureTarget(
        name: String,
        productName: String,
        product: Product = .staticLibrary,
        dependencies: [Module],
        hasResources: Bool = false
    ) -> Self {
         target(
            name: name,
            destinations: .iOS,
            product: .staticLibrary,
            productName: productName,
            bundleId: "com.swiftbuddies.\(productName.lowercased())",
            deploymentTargets: .iOS("17.0"),
            sources: ["SwiftBuddiesIOS/Targets/\(name)Module/Sources/**"],
            resources: hasResources ? ["SwiftBuddiesIOS/Targets/\(name)Module/Resources/**"] : [],
            dependencies: dependencies.compactMap({ $0.targetDependency }))
    }
}
