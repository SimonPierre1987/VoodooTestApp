//
//  UserDTO.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation

struct UserDTO: Codable {
    private enum CodingKeys: String, CodingKey  {
        case id
        case username
        case firstName = "first_name"
        case lastName = "last_name"
        case bio
        case links
        case profileImage = "profile_image"
    }

    let id: String
    let username: String
    let firstName: String
    let lastName: String?
    let bio: String?
    let links: LinkDTO
    let profileImage: ProfileImageDTO
}

extension UserDTO {
    static var currentUser: UserDTO {
        return UserDTO(
            id: "currentUserID",
            username: "CurrentUser",
            firstName: "current",
            lastName: "user",
            bio: "current user bio",
            links: LinkDTO(photos: "test", likes: "test"),
            profileImage: ProfileImageDTO(
                small: "test",
                medium: "test",
                large: "test"
            )
        )
    }
}
