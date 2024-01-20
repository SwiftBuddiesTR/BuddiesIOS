import SwiftUI
import Design

public struct ContributorsView: View {
    
    public init() { }
    
    public var body: some View {
        VStack {
            Text("Contributors Module")
            Text(ViewEnum.hello.rawValue)
        }
    }
}

#Preview {
    ContributorsView()
}
