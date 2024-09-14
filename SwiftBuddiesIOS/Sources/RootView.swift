import SwiftUI
import Login
import Onboarding
import Design

struct RootView: View {
    @AppStorage("isSplashScreenViewed") var isOnboardingScreenViewed : Bool = false
    @State private var isLoggedIn: Bool = false
    
    let pub = NotificationCenter.default
        .publisher(for: .signOutNotification)
    
    init() { }

    var body: some View {
        SuitableRootView()
    }
    
    @ViewBuilder
    private func SuitableRootView() -> some View {
        if isOnboardingScreenViewed {
            ZStack {
                if isLoggedIn {
                    TabFlowView()
                }
            }
            .onReceive(pub) { _ in
                isLoggedIn = false
            }
            .fullScreenCover(isPresented: $isLoggedIn.negated, content: {
                AuthenticationView()
            })
        } else {
            OnboardingBuilder.build()
        }
    }
}

#Preview {
    RootView()
}
