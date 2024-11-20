//
//  FeedItemView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation
import SwiftUI

struct FeedItemView: View {

    let feedPhoto: SharedPhoto

    // MARK: - State
    @Binding var lastDisplayedPhoto: SharedPhoto?
    @Binding var selectedUser: UserEntity?

    var body: some View {
        VStack {
            switch self.feedPhoto.contentSource {
            case .url(let url):
                AsyncImage(url: url)
                    .frame(width: 350, height: 300)
                    .clipShape(.rect(cornerRadius: 20))
            case .image(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 300)
                    .clipShape(.rect(cornerRadius: 20))
            case .embeddedAsset(let string):
                Image(string)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 300)
                    .clipShape(.rect(cornerRadius: 20))
            }

            HStack {
                Label("\(String(self.feedPhoto.likes)) likes", systemImage:  self.feedPhoto.isLikedByUser ? "heart.fill" : "heart")
                Spacer()
                Label("\(self.feedPhoto.chatThread.messages.count) messages", systemImage: "message")
            }
            .font(.caption)
            .foregroundStyle(.gray)
        }
        .padding(.horizontal)
        .overlay(alignment: .topLeading) {
            UserProfilePictureView(
                user: self.feedPhoto.author,
                profileSize: .small,
                selectedUser: self.$selectedUser
            )
        }
        .onAppear {
            self.lastDisplayedPhoto = self.feedPhoto
        }
    }
}

