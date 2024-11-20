//
//  UserEntity.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation

struct UserEntity: Equatable {
    let id: String
    let username: String
    let firstName: String
    let lastName: String?
    let bio: String?
    let links: UserLink
    let profileImage: UserProfileImage

    init(userDTO: UserDTO) {
        self.id = userDTO.id
        self.username = userDTO.username
        self.firstName = userDTO.firstName
        self.lastName = userDTO.lastName
        self.bio = userDTO.bio
        self.links = UserLink(linkDTO: userDTO.links)
        self.profileImage = UserProfileImage(profileImageDTO: userDTO.profileImage)
    }
}

extension UserEntity {
    static var currentUser: UserEntity {
        return UserEntity(userDTO: UserDTO.currentUser)
    }

    static func toUserDTO(userEntity: UserEntity) -> UserDTO {
        return UserDTO(
            id: userEntity.id,
            username: userEntity.username,
            firstName: userEntity.firstName,
            lastName: userEntity.lastName,
            bio: userEntity.bio,
            links: UserLink.toLinkDTO(userLink: userEntity.links),
            profileImage: UserProfileImage.toProfileImageDTO(userProfileImage: userEntity.profileImage)
        )
    }

    static var mockOne: UserEntity {
        return UserEntity(
            userDTO: UserDTO(
                id: "eySMK9KwmJU",
                username: "samsungmemory",
                firstName: "Samsung",
                lastName: "Samsung",
                bio: "Memory for every endeavor – get fast storage solutions that work seamlessly with your devices.",
                links: LinkDTO(photos: "https://api.unsplash.com/users/samsungmemory/photos", 
                               likes:  "https://api.unsplash.com/users/samsungmemory/likes"),
                profileImage: ProfileImageDTO(small: "https://images.unsplash.com/profile-1602741027167-c4d707fcfc85image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=32&h=32", medium: " https://images.unsplash.com/profile-1602741027167-c4d707fcfc85image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=64&h=64", large: "https://images.unsplash.com/profile-1602741027167-c4d707fcfc85image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128")
            )
        )
    }
}

extension UserEntity: Hashable {
    func hash(into hasher: inout Hasher) {
        return hasher.combine(self.id)
    }
}
