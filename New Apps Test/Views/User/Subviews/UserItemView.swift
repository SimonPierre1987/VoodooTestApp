//
//  UserItemView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation
import SwiftUI

struct UserItemView: View {
    // MARK: Services
    let allPhotosService = AllPhotosService()
    let singlePhotoDownloader: SinglePhotoDownloader
    let chatThread = Thread.mock

    // MARK: - States
    @State var userPhoto: PhotoEntity
    @State var showLikeAction: Bool = false

    @State var savedImage: Image?
    @Binding var photoToDisplayFullScreen: Image?
    
    var body: some View {
        VStack {
            PhotoView(singlePhotoDownloader: self.singlePhotoDownloader, width: UserLayoutConstant.fixedUserImageSize, height: UserLayoutConstant.fixedUserImageSize, photo: self.$userPhoto)
                .likeOrDislikePhoto(photo: self.$userPhoto, showLikeAction: self.$showLikeAction, size: 32)
            HStack {
                Image(systemName: self.userPhoto.isLikedByUser ? "heart.fill" : "heart")
//                    .onTapGesture {
//                        Task { await self.likeOrDislikePhoto() }
//                    } 
                // TODO: fix
                Spacer()
                Label("\(self.chatThread.messages.count)", systemImage: "message")
            }
            .font(.caption)
            .foregroundStyle(.gray)
        }
        .padding(.horizontal)
        .likeOrDislikePhoto(photo: self.$userPhoto, showLikeAction: self.$showLikeAction, size: 32)
        .onTapGesture {
            withAnimation {
                self.photoToDisplayFullScreen = self.savedImage
            }
        }
    }
}
