import SwiftUI
import Auth

public struct ContentView: View {
    public init() {}

    public var body: some View {
        Button(action: {
            Task { @MainActor in
                let _ = try? await Authenticator.shared.signIn()
            }
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
