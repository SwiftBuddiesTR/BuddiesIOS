import SwiftUI
import Design
import Auth

public struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding private var isLoggedIn: Bool
    
    public init(isLoggedIn: Binding<Bool>) {
        _isLoggedIn = isLoggedIn
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            swiftBuddies
                .padding(.bottom)
            
            Group {
                googleSignInButton
                appleSignInButton
            }
            .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .onChange(of: viewModel.userInfo) { _, newValue in
            isLoggedIn = newValue != nil
        }
    }
}

extension AuthenticationView {
    private var swiftBuddies: some View {
        DesignAsset.swiftBuddiesImage.swiftUIImage
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(height: 250)
    }
    
    private var googleSignInButton: some View {
        Button {
            viewModel.signIn(provider: .google)
        } label: {
            Text("Sign in with Google")
                .withLoginButtonFormatting()
        }
    }
    
    private var appleSignInButton: some View {
        Button(action: {
            viewModel.signIn(provider: .apple)
        }, label: {
            SignInWithAppleButtonViewRepresentable(type: .default, style: .white)
                .allowsHitTesting(false)
                .withLoginButtonFormatting()
        })
    }
}

#Preview {
    AuthenticationView(isLoggedIn: .constant(false))
}
