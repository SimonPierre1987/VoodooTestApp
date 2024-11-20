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
    let isSelf: Bool

    init(userDTO: UserDTO, isSelf: Bool) {
        self.id = userDTO.id
        self.username = userDTO.username
        self.firstName = userDTO.firstName
        self.lastName = userDTO.lastName
        self.bio = userDTO.bio
        self.links = UserLink(linkDTO: userDTO.links)
        self.profileImage = UserProfileImage(profileImageDTO: userDTO.profileImage)
        self.isSelf = isSelf
    }
}

extension UserEntity {
    static var currentUser: UserEntity {
        return UserEntity(userDTO: UserDTO.currentUser, isSelf: true)
    }

    static var chatUser: UserEntity {
        return UserEntity(userDTO: UserDTO.chatUser, isSelf: false)
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
}

extension UserEntity: Hashable {
    func hash(into hasher: inout Hasher) {
        return hasher.combine(self.id)
    }
}
