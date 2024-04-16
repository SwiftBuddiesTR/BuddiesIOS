import SwiftUI
import Auth
import Map
import Onboarding
import Design

public struct ContentView: View {
    @State var isOnboardingSeen: Bool
    
    public init() {
        isOnboardingSeen = LocalData.manager.isOnboardingScreenViewed
    }

    public var body: some View {
        SuitableRootView()
    }
    
    
    @ViewBuilder
    private func SuitableRootView() -> some View {
        if isOnboardingSeen {
            TabFlow()
        } else {
            OnboardingBuilder.build(items:prepareOnboardingItems(),
                                    didSeenOnboarding: onboardingSeenAction)
        }
    }
    
    private func prepareOnboardingItems() -> [OnboardingItemModel] {
        [.init(id: 0,
               title: "onboardingItem.FirstTitle",
               description: "onboardingItem.FirstDescription",
               image: DesignAsset.onboardingWelcomeImage.swiftUIImage),
         .init(id: 1,
               title: "onboardingItem.SecondTitle",
               description: "onboardingItem.SecondDescription",
               image: DesignAsset.onboardingBuddiesImage.swiftUIImage)
        ]
    }
    
    private func onboardingSeenAction() {
        withAnimation(.easeInOut) { isOnboardingSeen = true }
        LocalData.manager.isOnboardingScreenViewed = isOnboardingSeen
        
    }
    
}

struct TabFlow: View {
    var body: some View {
        TabView {
            VStack {
                Button(action: {
                    Task {
                        try? await Authenticator.shared.signIn()
                    }
                }, label: {
                    Text("Login")
                })
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Feed")
            }
            
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
        }
    }
}

#Preview {
    ContentView()
}
