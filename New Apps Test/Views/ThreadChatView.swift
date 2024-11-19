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
    @State var thread: Thread
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

    private func submitNewMessage() {
        let newThreadMessage = ThreadMessage(author: User.mockUser1, 
                                             message: newMessage,
                                             date: Date())
        thread.messages.append(newThreadMessage)
        newMessage = ""
    }
}

private struct ChatMessageView: View {
    let message: ThreadMessage
    var body: some View {
        HStack {
            if message.author.isSelf {
                Spacer()
                bubbleView
                authorPhoto
            } else {
                authorPhoto
                bubbleView
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
    
    private var bubbleView: some View {
        Text(message.message)
            .padding(10)
            .background(Color(white: 0.9))
            .clipShape(.rect(cornerRadius: 20))
    }

    private var authorPhoto: some View {
        Image(uiImage: UIImage(named: message.author.photo)!)
            .resizable()
            .frame(width: 40, height: 40)
            .clipShape(.circle)
    }
}

#Preview {
    ThreadChatView(thread: Thread.mock)
}
