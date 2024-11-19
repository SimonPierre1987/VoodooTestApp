//
//  ImageInfo.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation

struct ImageInfo: Codable {
    let id: String
    let urls: ImageUrl
    let user: UserDTO
}

struct ImageUrl: Codable {
    let regular: String
}
