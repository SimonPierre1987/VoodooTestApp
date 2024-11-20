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
    case like(photoId: String)
    case dislike(photoId: String)
}

extension UnsplashAPIEndpoint: Endpoint {
    static let accessToken = "8j7cdQS9HM1tfIomk_dUwqrIZ7wnymEECz6xk6OPP6k"

    var baseUrlSting: String {
        switch self {
        case .photo, .user, .me, .userPhotos, .like, .dislike:
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
        case .like(let photoId):
            return "/photos/\(photoId)/like"
        case .dislike(let photoId):
            return "/photos/\(photoId)/like"
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
        case .like:
            return HTTPMethod.post
        case .dislike:
            return HTTPMethod.delete
        }
    }

    var parameters: [String: String]? {
        switch self {
        case .photo(let page, let count):
            let parameters = [
                "page": String(page),
                "per_page" : String(count)
            ]
            return parameters
        case .user:
            return nil
        case .me:
            return nil
        case .userPhotos:
            return nil
        case .like:
            return nil
        case .dislike:
            return nil
        }
    }
}
