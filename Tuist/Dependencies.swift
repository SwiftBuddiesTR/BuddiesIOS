//
//  Dependencies.swift
//  Config
//
//  Created by dogukaan on 20.01.2024.
//

import Foundation
import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: .init(
        [.remote(url: "https://github.com/darkbringer1/DefaultNetworkOperationPackage",
                 requirement: .upToNextMajor(from: .init(1, 0, 0))),
         .remote(url: "https://github.com/SwiftUIX/SwiftUIX.git",
                 requirement: .upToNextMinor(from: .init(0, 1, 0)))]
    ),
    platforms: [.iOS, .macOS]
)
