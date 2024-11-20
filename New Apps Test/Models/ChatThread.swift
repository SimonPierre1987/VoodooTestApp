//
//  ChatThread.swift
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

struct ChatThread: Identifiable {

    let id = UUID()
    var members: [UserEntity] = []
    var messages: [ThreadMessage] = []

    static var mock: ChatThread {
        ChatThread(members: [UserEntity.currentUser, UserEntity.chatUser], messages: [
            ThreadMessage(author: UserEntity.currentUser, message: "Hey what's up ?", date: Date().advanced(by: -410)),
            ThreadMessage(author: UserEntity.currentUser, message: "Remember that place ?", date: Date().advanced(by: -400)),
            ThreadMessage(author: UserEntity.chatUser, message: "Oh yeah that was crazy 😂", date: Date().advanced(by: -250)),
            ThreadMessage(author: UserEntity.currentUser, message: "Up to do it again ?", date: Date().advanced(by: -200)),
            ThreadMessage(author: UserEntity.chatUser, message: "Yess would love it !!", date: Date().advanced(by: -100))
        ])
    }
}

extension ChatThread: Hashable {
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    static func == (lhs: ChatThread, rhs: ChatThread) -> Bool {
        lhs.id == rhs.id
    }
}

struct ThreadMessage: Identifiable {
    let id = UUID()
    let author: UserEntity
    let message: String
    let date: Date
}
