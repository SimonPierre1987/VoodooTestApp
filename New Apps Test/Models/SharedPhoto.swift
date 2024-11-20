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

struct SharedPhoto: Identifiable {
    let id = UUID()
    let photoId: String
    let author: UserEntity
    let contentSource: ContentSource
    let chatThread: Thread
    
    let description: String?
    let likedByUser: Bool
    let likes: Int

    enum ContentSource {
        case url(URL)
        case image(Image)
        case embeddedAsset(String)
    }
}

extension SharedPhoto {
    init(imageDTO: ImageDTO,
         chatThread: Thread) {
        self.photoId = imageDTO.id
        self.author = UserEntity(userDTO: imageDTO.user)
        let url = URL(string: imageDTO.urls.regular)!
        self.contentSource = .url(url)

        self.description = imageDTO.description
        self.likedByUser = imageDTO.likedByUser ?? false
        self.likes = imageDTO.likes ?? 0

        self.chatThread = chatThread
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
