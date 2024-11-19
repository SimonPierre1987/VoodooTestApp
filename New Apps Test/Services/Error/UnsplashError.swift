//
//  UnsplashError.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation

enum UnsplashError: Error {
    case unknown
    case incorrectUrl
    case clientError(_ error: Error?)
    case serverError(_ response: URLResponse?)
    case dataDecodingError
}
