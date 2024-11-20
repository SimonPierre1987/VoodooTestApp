//
//  ChatView.swift
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

import SwiftUI

struct ThreadChatView: View {
    // MARK: - States
    @State var thread: ChatThread
    @State var newMessage = ""

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack {
                    ForEach(thread.messages) { message in
                        ChatMessageView(message: message)
                    }
                }
            }
            inputView
        }
    }
}

// MARK: - Messaging
private extension ThreadChatView {
    private func submitNewMessage() {
        let newThreadMessage = ThreadMessage(author: UserEntity.currentUser,
                                             message: newMessage,
                                             date: Date())
        thread.messages.append(newThreadMessage)
        newMessage = ""
    }
}

// MARK: - ViewBuilder
private extension ThreadChatView {
    @ViewBuilder
    private var inputView: some View {
        HStack {
            TextField("New message...", text: $newMessage)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onSubmit {
                    submitNewMessage()
                }
                .padding(.horizontal)
            Button {
                submitNewMessage()
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.title3)
            }
            .disabled(newMessage.isEmpty)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color(white: 0.9))
    }
}

#Preview {
    ThreadChatView(thread: ChatThread.mock)
}
