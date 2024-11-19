//
//  User.swift
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

struct User: Identifiable {
    let id = UUID()
    let name: String
    let photo: String
    let isSelf: Bool

    static var random: User {
        [mockUser1, mockUser2, mockUser3, mockUser4].randomElement()!
    }

    static var mockUser1: User {
        User(name: "Joe", photo: "User1", isSelf: true)
    }
    
    static var mockUser2: User {
        User(name: "Amelia", photo: "User2", isSelf: false)
    }
    
    static var mockUser3: User {
        User(name: "Farid", photo: "User3", isSelf: false)
    }
    
    static var mockUser4: User {
        User(name: "Nathalie", photo: "User4", isSelf: false)
    }
}
