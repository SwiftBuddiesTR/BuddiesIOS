import SwiftUI
import Design

struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding private var showSignInView: Bool
    
    @FocusState private var fieldInFocus: LoginField?
    
    enum LoginField: Hashable {
        case email
        case password
    }
    
    init(showSignInView: Binding<Bool>) {
        self._showSignInView = showSignInView
    }
    
    var body: some View {
        VStack(spacing: 10) {
            swiftBuddiesImage
            
            signInText
            
            emailTextField
            passwordTextField
            
            forgotPasswordButton
            
            signInButton
        }
    }
}

// MARK: Views

extension SignInEmailView {
    private var swiftBuddiesImage: some View {
        DesignAsset.swiftBuddiesImage.swiftUIImage
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(height: 250)
    }
    
    private var signInText: some View {
        Text("Sign in to your account")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.primary.opacity(0.7))
    }
    
    private var emailTextField: some View {
        TextField("Email", text: $viewModel.email)
            .submitLabel(viewModel.password.isEmpty ? .continue : .done)
            .onSubmit {
                if viewModel.password.isEmpty {
                    fieldInFocus = .password
                }
            }
            .focused($fieldInFocus, equals: .email)
            .withLoginTextFieldFormatting(
                borderColor: viewModel.email.isEmpty ?
                Color.primary.opacity(0.7) : DesignAsset.loginStrokeColor.swiftUIColor
            )
    }
    
    private var passwordTextField: some View {
        HStack(spacing: 15) {
            if viewModel.visible {
                TextField("Password", text: $viewModel.password)
            } else {
                SecureField("Password", text: $viewModel.password)
            }
            Button(action: { viewModel.visible.toggle() }) {
                Image(systemName: viewModel.visible ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(Color.primary.opacity(0.7))
            }
        }
        .focused($fieldInFocus, equals: .password)
        .withLoginTextFieldFormatting(
            borderColor: viewModel.password.isEmpty ?
            Color.primary.opacity(0.7) : DesignAsset.loginStrokeColor.swiftUIColor
        )
    }
    
    private var forgotPasswordButton: some View {
        HStack {
            Spacer()
            Button(action: {
                Task {
                    try? await viewModel.forgotPassword()
                }
            }) {
                Text("Forgot password")
                    .fontWeight(.bold)
                    .foregroundColor(DesignAsset.loginStrokeColor.swiftUIColor)
            }
        }
    }
    
    private var signInButton: some View {
        Button(action: { signIn() }) {
            Text("Sign In")
                .withLoginButtonFormatting()
        }
        .clipShape(Capsule())
    }
}

// MARK: Functions

extension SignInEmailView {
    private func signIn() {
        if viewModel.email.isEmpty {
            fieldInFocus = .email
        } else if viewModel.password.isEmpty {
            fieldInFocus = .password
        } else {
            Task {
                do {
                    try await viewModel.signUp()
                    showSignInView = false
                    return
                } catch {
                    debugPrint(error)
                }
                
                do {
                    try await viewModel.signIn()
                    showSignInView = false
                    return
                } catch {
                    debugPrint(error)
                }
            }
        }
    }
}

#Preview {
    SignInEmailView(showSignInView: .constant(true))
}
