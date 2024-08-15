//
//  NetworkManager.swift
//  Auth
//
//  Created by Berkay Tuncel on 10.08.2024.
//

import Foundation
import Combine
import Auth

public final class NetworkManager {
    
    public init() {}
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(urlString: String)
        case unknown
        
        var errorDescription: String {
            switch self {
            case .badURLResponse(urlString: let url): "[🔥] Bad response from URL: \(url)"
            case .unknown: "[⚠️] Unknown error occured."
            }
        }
    }
    
    public static func download(request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ try handleURLResponse(output: $0, url: request.url) })
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    private static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL?) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(urlString: url?.description ?? "")
        }
        
        return output.data
    }
    
    public static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
