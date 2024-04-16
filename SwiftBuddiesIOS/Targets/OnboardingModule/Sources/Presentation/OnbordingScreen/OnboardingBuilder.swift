//
//  OnboardingBuilder.swift
//  Onboarding
//
//  Created by Halit Baskurt on 16.04.2024.
//

import Design


public struct OnboardingBuilder {
    public static func build(items: [OnboardingItemModel], didSeenOnboarding: OnboardingView.OnboardingDidSeenCompletion = nil) -> OnboardingView {
        .init(items: items, didSeenCompletion: didSeenOnboarding)
    }
}
