import SwiftUI
import Design
import Auth

public struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()

    public init() {
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
            do {
                try viewModel.signIn(provider: .google)
            } catch {
                debugPrint(error)
            }
        } label: {
            Text("Sign in with Google")
                .withLoginButtonFormatting()
        }
    }
    
    private var appleSignInButton: some View {
        Button {
            do {
                try viewModel.signIn(provider: .apple)
            } catch {
                debugPrint(error)
            }
        } label: {
            SignInWithAppleButtonViewRepresentable(type: .default, style: .white)
                .allowsHitTesting(false)
                .withLoginButtonFormatting()
        }
    }
}

#Preview {
    AuthenticationView()
}
