import SwiftUI
import Design

public struct AboutView: View {
    
    public init() { }
    
    public var body: some View {
        HeaderParallaxView {
            VStack {
                Text("About Module")
                Text(ViewEnum.hello.rawValue)
            }
        } content: {
            Text("About module content")
        }

    }
}

#Preview {
    AboutView()
}
