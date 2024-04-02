import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

extension Target {
    static func makeModule(
        name: String,
        dependencies: [TargetDependency] = [],
        hasResources: Bool = false
    ) -> Target {
        
        Target.target(
            name: name,
            destinations: .iOS,
            product: .staticFramework,
            productName: name,
            bundleId: "com.swiftbuddies.\(name.lowercased())",
            sources: ["Targets/SwiftBuddies\(name)/Sources/**"],
            resources: hasResources ? ["Targets/SwiftBuddies\(name)/Resources/**"] : [],
            dependencies: dependencies
        )
    }
    
//    static func makeModule(
//        name: String,
//        dependencies: [TargetDependency] = [],
//        hasResources: Bool = false
//    ) -> Target {
//        
//        Target.target(
//            name: name,
//            destinations: .iOS,
//            product: .dynamicLibrary,
//            productName: name,
//            bundleId: "com.swiftbuddies.\(name.lowercased())",
//            sources: ["Targets/SwiftBuddies\(name)/Sources/**"],
//            resources: hasResources ? ["Targets/SwiftBuddies\(name)/Resources/**"] : [],
//            dependencies: dependencies
//        )
//    }
}

extension TargetDependency {
    static func makeExternalTarget(name: String) -> TargetDependency {
        TargetDependency.external(name: name, condition: nil)
    }
}

struct ThirdParty {
    let name: String
    let url: String
    let version: Version
}

extension ThirdParty {
    static let network: ThirdParty = .init(
        name: "DefaultNetworkOperationPackage",
        url: "https://github.com/darkbringer1/DefaultNetworkOperationPackage",
        version: "1.0.0"
    )
    
    func toTargetDependency() -> TargetDependency {
        .external(name: self.name, condition: PlatformCondition.when(.all))
    }
    
    func toPackage() -> Package {
        .remote(url: self.url, requirement: .upToNextMajor(from: self.version))
    }
}

extension TargetDependency {
    static func package(_ thirdParty: ThirdParty) -> Self {
        thirdParty.toTargetDependency()
    }
}
extension Package {
    static func remote(_ thirdParty: ThirdParty) -> Self {
        thirdParty.toPackage()
    }
}
// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

//extension Package {
//    static let network: Package = .package(url: "https://github.com/darkbringer1/DefaultNetworkOperationPackage", from: "1.0.0")
//}


let designTarget = Target.makeModule(
    name: "Design",
    dependencies: [],
    hasResources: true
)
let contributorsModule = Target.makeModule(
    name: "Contributors",
    dependencies: [.target(designTarget)]
)
let mapModule = Target.makeModule(
    name: "Map",
    dependencies: [.target(designTarget)]
)
let aboutModule = Target.makeModule(
    name: "About",
    dependencies: [.target(designTarget)]
)
let feedModule = Target.makeModule(
    name: "Feed",
    dependencies: [
        .target(designTarget),
        .external(
            name: "DefaultNetworkOperationPackage",
            condition: nil
        )
    ]
)
let loginModule = Target.makeModule(
    name: "Login",
    dependencies: [
        .target(designTarget),
        .external(
            name: "DefaultNetworkOperationPackage",
            condition: nil
        ),
        .external(
            name: "FirebaseAuthCombine-Community",
            condition: nil
        ),
        .external(
            name: "FirebaseAuth",
            condition: nil
        )
    ]
)


// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(
    name: "SwiftBuddiesMain",
    destionations: .iOS,
    targets: [
        feedModule,
        mapModule,
        aboutModule,
        contributorsModule,
        designTarget,
        loginModule
    ]
)
