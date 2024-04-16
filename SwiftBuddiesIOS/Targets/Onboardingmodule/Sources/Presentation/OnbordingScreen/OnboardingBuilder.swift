//
//  OnboardingBuilder.swift
//  Onboarding
//
//  Created by Halit Baskurt on 16.04.2024.
//

import Design

public struct OnboardingBuilder {
    public static func build() -> OnboardingView {
        
        var onboardingItems: [OnboardingItemModel] = [
            .init(id: 0,
                  title: "onboardingItem.FirstTitle",
                  description: "onboardingItem.FirstDescription",
                  image: DesignAsset.onboardingWelcomeImage.swiftUIImage),
            .init(id: 1,
                  title: "onboardingItem.SecondTitle",
                  description: "onboardingItem.SecondDescription",
                  image: DesignAsset.onboardingBuddiesImage.swiftUIImage)
        ]
        
        return OnboardingView(items: onboardingItems)
    }
}
