// swift-tools-version: 5.9
import PackageDescription


#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers


let packageSettings = PackageSettings(
    productTypes: [
        "FirebaseAuthCombine-Community": .framework, // default is .staticFramework
        "FirebaseAuth": .framework
//        "SwiftUIX": .framework
    ]
)
#endif

let package = Package(
    name: "PackageName",
    platforms: [.iOS(.v13)], 
    dependencies: [
        .package(url: "https://github.com/darkbringer1/DefaultNetworkOperationPackage", from: "1.0.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.23.0")
    ]
)
