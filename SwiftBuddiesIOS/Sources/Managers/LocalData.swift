//
//  LocalData.swift
//  SwiftBuddiesIOS
//
//  Created by Halit Baskurt on 16.04.2024.
//

import SwiftUI

final class LocalData {
    private init() {}
    static let manager : LocalData = LocalData()
    
    @AppStorage("isSplashScreenViewed") var isOnboardingScreenViewed : Bool = false
}
