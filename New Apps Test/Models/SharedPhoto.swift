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
    let author: User
    let contentSource: ContentSource
    let chatThread: Thread
    
    enum ContentSource {
        case url(URL)
        case image(Image)
        case embeddedAsset(String)
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
