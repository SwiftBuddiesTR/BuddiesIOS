
import SwiftUI
import Design

public struct FeedView: View {
    
    public init() { }
    
    public var body: some View {
        VStack {
            Text("Feed Module")
            Text(ViewEnum.hello.rawValue)
        }
    }
}

#Preview {
    FeedView()
}
