//
//  ChatMessageView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 20/11/2024.
//

import SwiftUI

struct ChatMessageView: View {
    let message: ThreadMessage

    var body: some View {
        HStack {
            if self.message.author.isSelf {
                Spacer()
                self.bubbleView
                self.authorPhoto
            } else {
                self.authorPhoto
                self.bubbleView
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 0)
    }

    private var bubbleView: some View {
        Text(self.message.message)
            .padding(10)
            .background(Color(white: 0.9))
            .clipShape(.rect(cornerRadius: 20))
    }

    private var authorPhoto: some View {
        UserProfilePictureView(
            user: self.message.author,
            profileSize: .small
        )
    }
}
