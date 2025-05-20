//
//  ProfileModule.swift
//  BuddiesIOSManifests
//
//  Created by Anıl Taşkıran on 15.05.2025.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: "Profile",
    dependencies: [
        .design,
        .auth,
        .network,
        .core,
        .googleSignIn
    ]
) 