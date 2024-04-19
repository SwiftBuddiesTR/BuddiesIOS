//
//  LoginView.swift
//  Login
//
//  Created by Berkay Tuncel on 17.04.2024.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
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
                SignInEmailView(showSignInView: $showSignInView)
                
                dividerView
                
                anonymousSignInButton
                googleSignInButton
                appleSignInButton
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: 375)
        }
    }
}

extension AuthenticationView {
    private var dividerView: some View {
        ZStack {
            Divider()
            
            Text("or")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .background(.white)
        }
    }
    
    private var anonymousSignInButton: some View {
        Button {
            Task {
                do {
                    try await viewModel.signInAnonymous()
                    showSignInView = false
                } catch {
                    debugPrint(error)
                }
            }
        } label: {
            Text("Sign In Anonymously")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(DesignAsset.loginStrokeColor.swiftUIColor)
                .cornerRadius(10)
        }
    }
    
    private var googleSignInButton: some View {
        Button {
            Task {
                do {
                    try await viewModel.signInGoogle()
                    showSignInView = false
                } catch {
                    debugPrint(error)
                }
            }
        } label: {
            Text("Sign In With Google")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(DesignAsset.loginStrokeColor.swiftUIColor)
                .cornerRadius(10)
        }
    }
    
    private var appleSignInButton: some View {
        Button(action: {
            Task {
                do {
                    try await viewModel.signInApple()
                    showSignInView = false
                } catch {
                    debugPrint(error)
                }
            }
        }, label: {
            SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                .allowsHitTesting(false)
        })
        .frame(height: 55)
    }
}

#Preview {
    NavigationStack {
        AuthenticationView(showSignInView: .constant(true))
    }
}
