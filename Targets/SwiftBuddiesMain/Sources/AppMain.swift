import SwiftUI
import Feed
import Map
import About
import Contributors
import Login

enum AppTab: Int, Identifiable {
    case feed = 0
    case map
    case about
    case contributors
    case login
    
    var id: Int { rawValue }
}


@main
struct AppMain: App {
    
    @State var selectedTab: AppTab = .feed
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                LoginView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Login")
                    }
                    .tag(AppTab.login)
                
                FeedView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Feed")
                    }
                
                    .tag(AppTab.feed)
                MapView()
                    .tabItem {
                        Image(systemName: "map")
                        Text("Map")
                    }
                    .tag(AppTab.map)
                AboutView()
                    .tabItem {
                        Image(systemName: "info.circle")
                        Text("About")
                    }
                    .tag(AppTab.about)
                
                ContributorsView()
                    .tabItem {
                        Image(systemName: "person.3")
                        Text("Contributors")
                    }
                    .tag(AppTab.contributors)
            }
        }
    }
}
