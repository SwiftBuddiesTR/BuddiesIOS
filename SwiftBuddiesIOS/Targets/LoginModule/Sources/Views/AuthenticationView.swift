import SwiftUI
import Design
import Auth

public struct AuthenticationView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding private var showSignInView: Bool
    
    public init(showSignInView: Binding<Bool>) {
        self._showSignInView = showSignInView
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                swiftBuddiesImage
                
                Group {
                    googleSignInButton
                    appleSignInButton
                }
                .clipShape(Capsule())
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: 375)
        }
        .scrollIndicators(.hidden)
        .onTapGesture(perform: endTextEditing)
    }
}

extension AuthenticationView {
    private var swiftBuddiesImage: some View {
        DesignAsset.swiftBuddiesImage.swiftUIImage
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(height: 250)
    }
    
    private var googleSignInButton: some View {
        Button {
            Task {
                do {
                    try await viewModel.signIn(provider: .google)
                    showSignInView = false
                } catch {
                    debugPrint(error)
                }
            }
        } label: {
            Text("Sign In With Google")
                .withLoginButtonFormatting()
        }
    }
    
    private var appleSignInButton: some View {
        Button(action: {
            Task {
                do {
                    try await viewModel.signIn(provider: .apple)
                    showSignInView = false
                } catch {
                    debugPrint(error)
                }
            }
        }, label: {
            SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                .allowsHitTesting(false)
                .withLoginButtonFormatting()
        })
    }
}

#Preview {
    AuthenticationView(showSignInView: .constant(true))
}
