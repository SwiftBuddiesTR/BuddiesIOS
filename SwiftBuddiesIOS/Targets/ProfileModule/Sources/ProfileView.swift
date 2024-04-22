import SwiftUI
import Design

public struct ProfileView: View {
    
    @Binding var showSignInView: Bool
    
    public init(showSignInView: Binding<Bool>) {
        self._showSignInView = showSignInView
    }
    
    enum ProfileViews: String, CaseIterable {
        case about = "About"
        case settings = "Settings"
    }
    
    public var body: some View {
        List {
            ForEach(ProfileViews.allCases, id: \.self) { selectedView in
                NavigationLink(selectedView.rawValue) {
                    switch selectedView {
                    case .about:
                        AboutView()
                    case .settings:
                        SettingsView(showSignInView: $showSignInView)
                    }
                }
            }
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false))
    }
}
