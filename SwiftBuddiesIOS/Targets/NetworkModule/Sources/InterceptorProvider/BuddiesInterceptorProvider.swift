//
//  BuddiesInterceptorProvider.swift
//  SwiftBuddiesIOS
//
//  Created by dogukaan on 14.09.2024.
//

import Foundation
import BuddiesNetwork

public final class BuddiesInterceptorProvider: InterceptorProvider {
    let client: URLSessionClient
    
    public init(client: URLSessionClient) {
        self.client = client
    }
    
    public var currentToken: () -> String? = {
//        KeychainManager.shared.get(key: .accessToken)
        ""
    }
    
    public  func interceptors(for request: some Requestable) -> [Interceptor] {
        [
            MaxRetryInterceptor(maxRetry: 3),
            TokenProviderInterceptor(currentToken: currentToken),
            NetworkFetchInterceptor(client: client)
        ]
    }
    
    public func additionalErrorHandler(for request: some Requestable) -> (any ChainErrorHandler)? {
        AuthenticationErrorHandler()
    }
}

class AuthenticationErrorHandler: ChainErrorHandler {
    func handleError<Request>(
        error: any Error,
        chain: any RequestChain,
        request: HTTPRequest<Request>,
        response: HTTPResponse<Request>?,
        completion: @escaping (Result<Request.Data, any Error>) -> Void
    ) where Request: Requestable {
        if response?.httpResponse.statusCode == 401 {
            Task { @MainActor in
//                try await Authenticator.shared.logout()
                // TODO: Auto renew token request
                chain.cancel()
            }
        } else {
            completion(.failure(error))
        }
    }
}
 
public final class BuddiesRequestChainNetworkTransport {
    public static func getChainNetworkTransport(
        interceptorProvider: some InterceptorProvider
    ) -> any NetworkTransportProtocol {
        return DefaultRequestChainNetworkTransport(interceptorProvider: interceptorProvider)
    }
}
