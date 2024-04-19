//
//  SignInGoogleHelper.swift
//  Auth
//
//  Created by Berkay Tuncel on 18.04.2024.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

public struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
}

final public class SignInGoogleHelper {
    
    public init() { }
    
    @MainActor
    public func signIn() async throws -> GoogleSignInResultModel {
        guard let vc = UIApplication.shared.windows.first?.rootViewController else {
            throw URLError(.cannotFindHost)
        }

        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: vc)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let name = gidSignInResult.user.profile?.name
        let email = gidSignInResult.user.profile?.email

        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name, email: email)
        return tokens
    }
    
}
