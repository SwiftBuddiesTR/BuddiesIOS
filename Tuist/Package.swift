// swift-tools-version: 5.9
import PackageDescription


#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers


let packageSettings = PackageSettings(
    productTypes: [
        "DefaultNetworkOperationPackage": .dynamicLibrary, // default is .staticFramework
//        "SwiftUIX": .framework
    ]
)
#endif

//let network = Package(
//    name: "defaultnetworkoperationpackage",
//    dependencies: [
//        .package(url: "https://github.com/darkbringer1/DefaultNetworkOperationPackage", from: "1.0.0"),
//        .package(url: "https://github.com/SwiftUIX/SwiftUIX.git", from: "0.1.0"),
//    ]
//)
