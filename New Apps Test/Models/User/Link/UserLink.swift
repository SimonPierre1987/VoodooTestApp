//
//  UserLink.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation

struct UserLink: Equatable {
    let photos: String
    let likes: String
}

extension UserLink {
    init(linkDTO: LinkDTO) {
        self.likes = linkDTO.likes
        self.photos = linkDTO.photos
    }
}
