//
//  BuddiesClient.swift
//  SwiftBuddiesIOS
//
//  Created by dogukaan on 14.09.2024.
//

import Foundation
import BuddiesNetwork

final public class BuddiesClient {
    private let apiClient: APIClient
    
    public static var shared: BuddiesClient!
    
    public init(networkTransporter: NetworkTransportProtocol) {
        apiClient = .init(networkTransporter: networkTransporter)
    }
    
    public func perform<Request: Requestable>(
        _ request: Request,
        dispatchQueue: DispatchQueue = .main,
        completion: @escaping (Result<Request.Data, Error>) -> Void
    ) {
        apiClient.perform(
            request,
            dispatchQueue: dispatchQueue,
            completion: completion
        )
    }
    
    @discardableResult
    public func perform<Request: Requestable>(
        _ request: Request,
        dispatchQueue: DispatchQueue = .main
    ) async throws -> Request.Data {
        try await apiClient.perform(request, dispatchQueue: dispatchQueue)
    }
}
