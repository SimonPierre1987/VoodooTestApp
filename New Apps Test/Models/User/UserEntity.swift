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
    let lastName: String
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
}

extension UserEntity: Hashable {
    func hash(into hasher: inout Hasher) {
        return hasher.combine(self.id)
    }
}
