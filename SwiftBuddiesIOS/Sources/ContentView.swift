import SwiftUI
import Auth
import Map


public struct ContentView: View {
    public init() {}

    public var body: some View {
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
