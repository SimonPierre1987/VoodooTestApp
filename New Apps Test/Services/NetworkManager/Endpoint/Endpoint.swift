//
//  Endpoint.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
    case patch   = "PATCH"
}

protocol Endpoint {
    var baseUrlSting: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: String] { get }

    func createURLRequest() -> URLRequest?
}

extension Endpoint {
    func createURLRequest() -> URLRequest? {
        guard var components = URLComponents(string: self.baseUrlSting) else {
            return nil
        }

        let queryItems = self.parameters.map { URLQueryItem(name: $0.key, value: $0.value)}
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod.rawValue

        request.setValue("Client-ID 8j7cdQS9HM1tfIomk_dUwqrIZ7wnymEECz6xk6OPP6k", forHTTPHeaderField: "Authorization")
        request.setValue("v1", forHTTPHeaderField: "Accept-Version")
        return request
    }
}
