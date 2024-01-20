import SwiftUI
import Design

public struct AboutView: View {
    
    public init() { }
    
    public var body: some View {
        VStack {
            Text("About Module")
            Text(ViewEnum.hello.rawValue)
        }
    }
}

#Preview {
    AboutView()
}
