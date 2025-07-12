//
//  Modules+Codegen.swift
//  ProjectDescriptionHelpers
//
//  Created by Anıl Taşkıran on 15.05.2025.
//

import ProjectDescription

public extension Module {
    static let localicationCodegen = Target.target(
        name: "LocalizationCodegen",
        destinations: .macOS,
        product: .commandLineTool,
        productName: "LocalizationCodegen",
        bundleId: "com.swiftbuddies.localization",
        sources: ["SwiftBuddiesIOS/Targets/ScriptsModule/LocalizationCodegen/**"],
        scripts: [],
        dependencies: [.package(product: "ArgumentParser", type: .runtime, condition: .none)],
        coreDataModels: [],
        environmentVariables: [:],
        launchArguments: [],
        additionalFiles: [],
        buildRules: [],
        mergedBinaryType: .automatic,
        mergeable: false
    )

    static let colorPaletteCodegen = Target.target(
        name: "ColorPaletteCodegen",
        destinations: .macOS,
        product: .commandLineTool,
        productName: "ColorCodege",
        bundleId: "com.swiftbuddies.color",
        sources: ["SwiftBuddiesIOS/Targets/ScriptsModule/ColorPaletteCodegen/**"],
        scripts: [],
        dependencies: [.external(name: "ArgumentParser")],
        coreDataModels: [],
        environmentVariables: [:],
        launchArguments: [],
        additionalFiles: [],
        buildRules: [],
        mergedBinaryType: .automatic,
        mergeable: false
    )
}
