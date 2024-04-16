//
//  OnboardingItemModel.swift
//  Onboarding
//
//  Created by Halit Baskurt on 16.04.2024.
//

import SwiftUI


public struct OnboardingItemModel: Identifiable, Hashable {
    
    public init(id: Int,
                title: LocalizedStringKey,
                description: LocalizedStringKey,
                image: Image) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
    }
    
    
    public var id: Int
    public var title: LocalizedStringKey
    public var description: LocalizedStringKey
    public var image: Image
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id.hashValue)
    }
}
