//
//  Endpoint.swift
//  Auth
//
//  Created by Berkay Tuncel on 10.08.2024.
//

import Foundation
import Auth

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var parameters: [String: Any]? { get }
    
    func request() -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum Endpoint {
    case loginRequest(registerType: AuthSSOOption, accessToken: String)
}

extension Endpoint: EndpointProtocol {
    var baseURL: String { "https://swiftbuddies.vercel.app" }
    
    var path: String {
        switch self {
        case .loginRequest:
            return "/api/register"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .loginRequest:
            return .post
        }
    }
    
    var header: [String: String]? {
        let header: [String: String] = ["Content-type": "application/json; charset=UTF-8"]
        return header
    }
    
    var parameters: [String: Any]? {
        if case .loginRequest(let registerType, let accessToken) = self {
            return ["registerType": registerType.rawValue, "accessToken": accessToken]
        }
        
        return nil
    }
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else { fatalError("URL error") }
        
        components.path = path
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        if let header = header {
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return request
    }
}
