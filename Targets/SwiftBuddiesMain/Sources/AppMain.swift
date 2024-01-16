

import SwiftUI

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
                
                Text("Tab Content 1").tabItem { Text("Tab Label 1") }.tag(1)
                Text("Tab Content 2").tabItem { Text("Tab Label 2") }.tag(2)
            }
        }
    }
}
