import SwiftUI
import Design

public struct MapView: View {
    
    public init() { }
    
    public var body: some View {
        VStack {
            Text("Map Module")
            Text(ViewEnum.hello.rawValue)
        }
    }
}

#Preview {
    MapView()
}
