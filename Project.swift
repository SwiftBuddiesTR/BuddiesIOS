import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

extension Target {
    static func makeTarget(name: String, dependencies: [TargetDependency] = []) -> Target {
        Target(
            name: name,
            platform: .iOS,
            product: .framework,
            productName: name,
            bundleId: "com.swiftbuddies.\(name.lowercased())",
            sources: ["Targets/SwiftBuddies\(name)/Sources/**"],
            dependencies: dependencies
        //    resources: [],
        //    copyFiles: <#T##[CopyFilesAction]?#>,
        //    headers: <#T##Headers?#>,
        //    entitlements: <#T##Path?#>,
        //    scripts: <#T##[TargetScript]#>,
        //    settings: <#T##Settings?#>,
        //    coreDataModels: <#T##[CoreDataModel]#>,
        //    environment: <#T##[String : String]#>,
        //    launchArguments: <#T##[LaunchArgument]#>,
        //    additionalFiles: <#T##[FileElement]#>,
        //    buildRules: <#T##[BuildRule]#>
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
let designTarget = Target.makeTarget(name: "Design", dependencies: [swiftUIXDependency])
let feedModule = Target.makeTarget(name: "Feed", dependencies: [.target(designTarget), networkDependency])


// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(name: "SwiftBuddiesMain",
                          platform: .iOS,
                          additionalTargets: [feedModule, designTarget],
                          targetDependencies: [networkDependency])


