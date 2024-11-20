//
//  FeedItemView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation
import SwiftUI

struct FeedItemView: View {

    // MARK: - Services
    let singlePhotoDownloader: SinglePhotoDownloader
    let chatThread = Thread.mock

    // MARK: - State
    @Binding var feedPhoto: PhotoEntity
    @State var showLikeAction: Bool = false

    @Binding var lastDisplayedPhoto: PhotoEntity?
    @Binding var selectedUser: UserEntity?
    @Binding var photoToNavigate: PhotoEntity?

    var body: some View {
        VStack {
            PhotoView(singlePhotoDownloader: self.singlePhotoDownloader, width: 350, height: 300, photo: self.$feedPhoto)
                .likeOrDislikePhoto(photo: self.$feedPhoto, showLikeAction: self.$showLikeAction, size: 100)
            HStack {
                Label("\(String(self.feedPhoto.likes)) likes", 
                      systemImage:  self.feedPhoto.isLikedByUser ? "heart.fill" : "heart")
                Spacer()
                Label("\(self.chatThread.messages.count) messages", systemImage: "message")
            }
            .font(.caption)
            .foregroundStyle(.gray)
        }
        .overlay(alignment: .topLeading) {
            UserProfilePictureView(
                user: self.feedPhoto.author,
                profileSize: .small,
                selectedUser: self.$selectedUser
            )
        }
        .padding(.horizontal)
        .onAppear { self.lastDisplayedPhoto = self.feedPhoto }
        .onTapGesture { self.photoToNavigate = self.feedPhoto }
    }
}

