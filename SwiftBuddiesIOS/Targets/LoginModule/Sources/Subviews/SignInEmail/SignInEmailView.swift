//
//  SignInEmailView.swift
//  Login
//
//  Created by Berkay Tuncel on 19.04.2024.
//

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
            DesignAsset.swiftBuddiesImage.swiftUIImage
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(height: 250)
            
            Text("Log in to your account")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.primary.opacity(0.7))
            
            TextField("Email", text: $viewModel.email)
                .fontWeight(.bold)
                .focused($fieldInFocus, equals: .email)
                .textInputAutocapitalization(.never)
                .submitLabel(viewModel.password.isEmpty ? .continue : .done)
                .onSubmit {
                    if viewModel.password.isEmpty {
                        fieldInFocus = .password
                    }
                }
                .frame(height: 55)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(viewModel.email.isEmpty ? Color.primary.opacity(0.7) : DesignAsset.loginStrokeColor.swiftUIColor, lineWidth: 2)
                )
            
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
            .fontWeight(.bold)
            .focused($fieldInFocus, equals: .password)
            .textInputAutocapitalization(.never)
            .frame(height: 55)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(viewModel.password.isEmpty ? Color.primary.opacity(0.7) : DesignAsset.loginStrokeColor.swiftUIColor, lineWidth: 2)
            )
            
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
            
            Group {
                Button(action: { signIn() }) {
                    Text("Sign In")
                        .withLoginButtonFormatting()
                }
            }
            .background(DesignAsset.loginStrokeColor.swiftUIColor)
            .cornerRadius(10)
        }
    }
}

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
