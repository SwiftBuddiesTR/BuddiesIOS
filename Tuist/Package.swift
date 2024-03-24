// swift-tools-version: 5.9
import PackageDescription


//#if TUIST
//import ProjectDescription
//import ProjectDescriptionHelpers
//
//
//let packageSettings = PackageSettings(
//    productTypes: [
//        "DefaultNetworkOperationPackage": .staticLibrary, // default is .staticFramework
////        "SwiftUIX": .framework
//    ]
//)
//#endif

let package = Package(
    name: "PackageName",
    platforms: [.iOS(.v13)], 
    dependencies: [
        .package(url: "https://github.com/darkbringer1/DefaultNetworkOperationPackage", from: "1.0.0")
    ]
)
