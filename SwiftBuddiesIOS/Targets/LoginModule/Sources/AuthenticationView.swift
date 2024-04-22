//
//  LoginView.swift
//  Login
//
//  Created by Berkay Tuncel on 17.04.2024.
//

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
                SignInEmailView(showSignInView: $showSignInView)
                
                dividerView
                
                Group {
                    anonymousSignInButton
                    googleSignInButton
                    appleSignInButton
                }
                .clipShape(Capsule())
                
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
                .withLoginButtonFormatting()
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
                .withLoginButtonFormatting()
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
                .withLoginButtonFormatting()
        })
    }
}

#Preview {
    AuthenticationView(showSignInView: .constant(true))
}
