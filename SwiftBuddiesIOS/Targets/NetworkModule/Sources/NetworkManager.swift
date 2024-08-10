//
//  NetworkManager.swift
//  Auth
//
//  Created by Berkay Tuncel on 10.08.2024.
//

import Foundation
import Auth

public final class NetworkManager {
    public static let shared = NetworkManager()
    private init() {}
    
    private func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode <= 299 else {
                completion(.failure(NSError(domain: "Invalid Response", code: 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid Data Response", code: 0)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let error {
                completion(.failure(error))
            }
        }
        .resume()
    }
    
    public func loginRequest(registerType: AuthSSOOption, accessToken: String, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        let endpoint = Endpoint.loginRequest(registerType: registerType, accessToken: accessToken)
        request(endpoint, completion: completion)
    }
}
