//
//  OnboardingView.swift
//  Onboarding
//
//  Created by Halit Baskurt on 16.04.2024.
//

import SwiftUI
import Design

public struct OnboardingView: View {
    public typealias OnboardingDidSeenCompletion = (() -> Void)?
    
    init(items onboardingData:[OnboardingItemModel], didSeenCompletion: OnboardingDidSeenCompletion) {
        self.onboardingData = onboardingData
        self.didSeenCompletion = didSeenCompletion
    }
    
    @State private var currentOnboardingItem: Int = 0
    
    private var onboardingData: [OnboardingItemModel]
    
    var didSeenCompletion: OnboardingDidSeenCompletion
    
    public var body: some View {
        ZStack {
            DesignAsset.onboardingBackround.swiftUIColor
                .ignoresSafeArea()
            VStack {
                TabView(selection: $currentOnboardingItem) {
                    ForEach(0..<onboardingData.count, id: \.self) { index in
                        let model = onboardingData[index]
                        OnboardingCell(model: model)
                            .tag(index)
                    }.padding(.horizontal, 20)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .padding(.top,20)
                .onAppear { setPageIndicatorColor() }
                let isLastItem: Bool = onboardingData.count - 1 == currentOnboardingItem
                let buttonTitle: LocalizedStringKey = isLastItem ? "onboarding.StartButtonTitle": "onboarding.ButtonTitle"
                BuddiesActionButton(title: buttonTitle) {
                    if isLastItem {
                        didSeenCompletion?()
                    } else {
                        withAnimation { currentOnboardingItem += 1 }
                    }
                }
                .padding(.horizontal)
            }.padding()
        }
    }
    
    func setPageIndicatorColor() {
        UIPageControl
            .appearance()
            .currentPageIndicatorTintColor = .orange
        UIPageControl
            .appearance()
            .pageIndicatorTintColor = .orange
            .withAlphaComponent(0.2)
    }
}

