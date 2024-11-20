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
    static var chatUser: UserDTO {
        return UserDTO(
            id: "eySMK9KwmJU",
            username: "samsungmemory",
            firstName: "Samsung",
            lastName: "Samsung",
            bio: "Memory for every endeavor – get fast storage solutions that work seamlessly with your devices.",
            links: LinkDTO(photos: "https://api.unsplash.com/users/samsungmemory/photos",
                           likes:  "https://api.unsplash.com/users/samsungmemory/likes"),
            profileImage: ProfileImageDTO(
                small: "https://images.unsplash.com/profile-1602741027167-c4d707fcfc85image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=32&h=32",
                medium: " https://images.unsplash.com/profile-1602741027167-c4d707fcfc85image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=64&h=64",
                large: "https://images.unsplash.com/profile-1602741027167-c4d707fcfc85image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
            )
        )
    }

    static var currentUser: UserDTO {
        return UserDTO(
            id: "uqNXqhDTb6A",
            username: "filizelaerts",
            firstName: "Filiz",
            lastName: "Elaerts",
            bio: "Amateur Photographer",
            links: LinkDTO(photos: "https://api.unsplash.com/users/filizelaerts/photos",
                           likes:  "https://api.unsplash.com/users/filizelaerts/likes"),
            profileImage: ProfileImageDTO(
                small: "https://images.unsplash.com/profile-fb-1580397817-550d9c342b68.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=32&h=32",
                medium: "https://images.unsplash.com/profile-fb-1580397817-550d9c342b68.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=64&h=64",
                large: "https://images.unsplash.com/profile-fb-1580397817-550d9c342b68.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128")
        )
    }
}
