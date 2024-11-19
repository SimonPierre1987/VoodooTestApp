//
//  Thread.swift
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

struct Thread: Identifiable {

    let id = UUID()
    var members: [User] = []
    var messages: [ThreadMessage] = []

    static var mock: Thread {
        Thread(members: [User.mockUser1, User.mockUser2], messages: [
            ThreadMessage(author: User.mockUser1, message: "Hey what's up ?", date: Date().advanced(by: -410)),
            ThreadMessage(author: User.mockUser1, message: "Remember that place ?", date: Date().advanced(by: -400)),
            ThreadMessage(author: User.mockUser2, message: "Oh yeah that was crazy 😂", date: Date().advanced(by: -250)),
            ThreadMessage(author: User.mockUser1, message: "Up to do it again ?", date: Date().advanced(by: -200)),
            ThreadMessage(author: User.mockUser2, message: "Yess would love it !!", date: Date().advanced(by: -100))
        ])
    }
}

extension Thread: Hashable {
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    static func == (lhs: Thread, rhs: Thread) -> Bool {
        lhs.id == rhs.id
    }
}

struct ThreadMessage: Identifiable {
    let id = UUID()
    let author: User
    let message: String
    let date: Date
}
