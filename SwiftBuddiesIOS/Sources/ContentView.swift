import SwiftUI
import Auth
import Map
import Onboarding
import Design

public struct ContentView: View {
    @AppStorage("isSplashScreenViewed") var isOnboardingScreenViewed : Bool = false
    
    public init() { }

    public var body: some View {
        SuitableRootView()
    }
    
    @ViewBuilder
    private func SuitableRootView() -> some View {
        if isOnboardingScreenViewed {
            TabFlow()
        } else {
            OnboardingBuilder.build()
        }
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
