//
//  Photo.swift
//  New Apps Test
//
//  Created by Michel-André Chirita on 27/06/2024.
//

/*
 --------------------------------------------------
 -- Voodoo New Apps Tech Test
 -- BOOSTRAP FILE
 -- Feel free to modify or dismiss it as you like !
 --------------------------------------------------
 */

import Foundation
import SwiftUI

@Observable
final class SharedPhoto: Identifiable {
    let id = UUID()
    let photoId: String
    let author: UserEntity
    let contentSource: ContentSource

    let description: String?
    var isLikedByUser: Bool
    let likes: Int

    init(
        photoId: String,
        author: UserEntity,
        contentSource: ContentSource,
        description: String?,
        isLikedByUser: Bool,
        likes: Int
    ) {
        self.photoId = photoId
        self.author = author
        self.contentSource = contentSource
        self.description = description
        self.isLikedByUser = isLikedByUser
        self.likes = likes
    }
}

extension SharedPhoto {
    convenience init(imageDTO: ImageDTO) {
        let url = URL(string: imageDTO.urls.regular)!

        self.init(
            photoId: imageDTO.id,
            author: UserEntity(userDTO: imageDTO.user),
            contentSource: .url(url),
            description: imageDTO.description ?? "",
            isLikedByUser: imageDTO.likedByUser ?? false,
            likes: imageDTO.likes ?? 0
        )
    }
}

extension SharedPhoto {
    static func toImageDTO(sharedPhoto: SharedPhoto, isLikedByUser: Bool) -> ImageDTO {
        let newNumberOfLike = isLikedByUser ? sharedPhoto.likes + 1 : sharedPhoto.likes
        return ImageDTO(
            id: sharedPhoto.photoId,
            urls: ContentSource.toImageUrlDTO(contentSource: sharedPhoto.contentSource),
            user: UserEntity.toUserDTO(userEntity: sharedPhoto.author),
            description: sharedPhoto.description,
            likedByUser: isLikedByUser,
            likes: newNumberOfLike
        )
    }
}

extension SharedPhoto: Hashable {
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    static func == (lhs: SharedPhoto, rhs: SharedPhoto) -> Bool {
        lhs.id == rhs.id
    }
}

