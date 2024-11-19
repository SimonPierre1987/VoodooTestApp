//
//  UnsplashAPI.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation

enum UnsplashAPIEndpoint {
    case photo(page: Int, countPerPage: Int)
}

extension UnsplashAPIEndpoint: Endpoint {
    static let accessToken = "8j7cdQS9HM1tfIomk_dUwqrIZ7wnymEECz6xk6OPP6k"

    var baseUrlSting: String {
        switch self {
        case .photo:
            return "https://api.unsplash.com/"
        }
    }

    var path: String {
        switch self {
        case .photo:
            return "/photos"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .photo:
            return HTTPMethod.get
        }
    }

    var parameters: [String: String] {
        switch self {
        case .photo(let page, let count):
            let parameters = [
                "page": String(page),
                "per_page" : String(count),
                "client_id" : Self.accessToken
            ]
            return parameters
        }
    }
}
