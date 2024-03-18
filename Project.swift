import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

extension Target {
    static func makeModule(name: String, dependencies: [TargetDependency] = [], hasResources: Bool = false) -> Target {
        Target.target(
            name: name,
            destinations: .iOS,
            product: .framework,
            productName: name,
            bundleId: "com.swiftbuddies.\(name.lowercased())",
            sources: ["Targets/SwiftBuddies\(name)/Sources/**"],
            resources: hasResources ? ["Targets/SwiftBuddies\(name)/Resources/**"] : [],
            dependencies: dependencies
        )
    }
}

extension TargetDependency {
    static func makeExternalTarget(name: String) -> TargetDependency {
        TargetDependency.external(name: name, condition: nil)
    }
}

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

let networkDependency = TargetDependency.makeExternalTarget(name: "DefaultNetworkOperationPackage")
let swiftUIXDependency = TargetDependency.makeExternalTarget(name: "SwiftUIX")
let designTarget = Target.makeModule(
    name: "Design",
    dependencies: [swiftUIXDependency],
    hasResources: true
)

let contributorsModule = Target.makeModule(
    name: "Contributors",
    dependencies: [.target(designTarget), networkDependency]
)
let mapModule = Target.makeModule(
    name: "Map",
    dependencies: [.target(designTarget), networkDependency]
)
let aboutModule = Target.makeModule(
    name: "About",
    dependencies: [.target(designTarget), networkDependency]
)
let feedModule = Target.makeModule(
    name: "Feed",
    dependencies: [.target(designTarget), networkDependency]
)


// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(
    name: "SwiftBuddiesMain",
    destionations: .iOS,
    additionalTargets: [
        feedModule,
        mapModule,
        aboutModule,
        contributorsModule,
        designTarget
    ],
    targetDependencies: [networkDependency]
)


