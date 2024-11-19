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
    let id = UUID() // TODO: use the backend id
    let author: UserEntity
    let contentSource: ContentSource
    let chatThread: Thread
    
    enum ContentSource {
        case url(URL)
        case image(Image)
        case embeddedAsset(String)
    }
}

extension SharedPhoto {
    init(imageDTO: ImageDTO,
         chatThread: Thread) {
        let url = URL(string: imageDTO.urls.regular)!
        self.contentSource = .url(url)
        self.chatThread = chatThread
        self.author = UserEntity(userDTO: imageDTO.user)
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
