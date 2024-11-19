//
//  UnsplashAPI.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation

enum UnsplashAPIEndpoint {
    case photo(page: Int, countPerPage: Int)
    case user(userName: String)
    case me
    case userPhotos(username: String)
}

extension UnsplashAPIEndpoint: Endpoint {
    static let accessToken = "8j7cdQS9HM1tfIomk_dUwqrIZ7wnymEECz6xk6OPP6k"

    var baseUrlSting: String {
        switch self {
        case .photo, .user, .me, .userPhotos:
            return "https://api.unsplash.com/"
        }
    }

    var path: String {
        switch self {
        case .photo:
            return "/photos"
        case .user(let userName):
            return "/users/\(userName)"
        case .me:
            return "/me"
        case .userPhotos(let username):
            return "/users/\(username)/photos"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .photo:
            return HTTPMethod.get
        case .user:
            return HTTPMethod.get
        case .me:
            return HTTPMethod.get
        case .userPhotos:
            return HTTPMethod.get
        }
    }

    var parameters: [String: String] {
        switch self {
        case .photo(let page, let count):
            let parameters = [
                "page": String(page),
                "per_page" : String(count)
            ]
            return parameters
        case .user:
            return [:]
        case .me:
            return [:]
        case .userPhotos:
            return [:]
        }
    }
}
