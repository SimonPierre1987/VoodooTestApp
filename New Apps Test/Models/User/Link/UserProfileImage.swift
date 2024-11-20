//
//  UserProfileImage.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation

struct UserProfileImage: Equatable {
    let smallUrl: URL?
    let mediumUrl: URL?
    let largeUrl: URL?
}

extension UserProfileImage {
    init(profileImageDTO: ProfileImageDTO) {
        self.smallUrl = URL(string: profileImageDTO.small)
        self.mediumUrl = URL(string: profileImageDTO.medium)
        self.largeUrl = URL(string: profileImageDTO.large)
    }

    static func toProfileImageDTO(userProfileImage: UserProfileImage) -> ProfileImageDTO {
        return ProfileImageDTO(
            small: userProfileImage.smallUrl?.absoluteString ?? "",
            medium: userProfileImage.mediumUrl?.absoluteString ?? "",
            large: userProfileImage.largeUrl?.absoluteString ?? ""
        )
    }
}
