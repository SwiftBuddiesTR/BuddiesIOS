//
//  LoginDataService.swift
//  SwiftBuddiesIOS
//
//  Created by Berkay Tuncel on 15.08.2024.
//

import Foundation
import Combine
import Auth

@MainActor
public final class LoginDataService {
    @Published public private(set) var userInfo: SignInResponse?
    
    private var userSubscription: AnyCancellable?
    
    public init() {}
    
    public func loginRequest(with signInRequest: SignInRequest) {
        let endpoint = Endpoint.loginRequest(
            registerType: signInRequest.type,
            accessToken: signInRequest.accessToken
        )
        loginRequest(endpoint: endpoint)
    }
    
    private func loginRequest(endpoint: Endpoint) {
        userSubscription = NetworkManager.download(request: endpoint.request())
            .decode(type: SignInResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion) { [weak self] userInfoResponse in
                self?.userInfo = userInfoResponse
            }
    }
}
