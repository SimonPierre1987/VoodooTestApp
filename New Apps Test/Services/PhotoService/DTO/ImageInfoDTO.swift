//
//  ImageDTO.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation

struct ImageDTO: Codable {
    let id: String
    let urls: ImageUrlDTO
    let user: UserDTO
    let description: String?
    let likedByUser: Bool?
}

struct ImageUrlDTO: Codable {
    let regular: String
}

extension Array where Element == ImageDTO {
    func toSharedPhoto() -> [SharedPhoto] {
        return self.map { SharedPhoto(imageDTO: $0, chatThread: Thread.mock) }
    }
}
