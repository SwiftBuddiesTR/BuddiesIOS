import SwiftUI
import Auth
import Map
import Feed
import About
import Contributors

enum AppTab: Int, Identifiable {
    case feed = 0
    case map
    case about
    case contributors
//    case login
    
    var id: Int { rawValue }
}

public struct ContentView: View {
    @State var selectedTab: AppTab = .feed

    public init() {}

    public var body: some View {
        TabView(selection: $selectedTab) {
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
