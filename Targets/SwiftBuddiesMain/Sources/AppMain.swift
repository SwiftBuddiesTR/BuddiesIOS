import SwiftUI
import Feed

enum AppTab: Int, Identifiable {
    case map = 0
    case feed
    case about
    
    var id: Int { rawValue }
}


@main
struct AppMain: App {
    
    @State var selectedTab: AppTab = .feed
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                FeedView()
            }
        }
    }
}
