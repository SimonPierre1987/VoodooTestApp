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

    // MARK: - States
    @State var userPhoto: SharedPhoto
    @State var showLikeAction: Bool = false

    @State var savedImage: Image?
    @Binding var photoToDisplayFullScreen: Image?
    
    var body: some View {
        VStack {
            switch self.userPhoto.contentSource {
            case .url(let url):
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                        .onAppear {
                            self.savedImage = image
                        }
                } placeholder: {
                    ProgressView().progressViewStyle(.circular)
                }
                .frame(width: UserLayoutConstant.fixedUserImageSize, 
                       height: UserLayoutConstant.fixedUserImageSize)
                .clipShape(.rect(cornerRadius: 20))
            case .image(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UserLayoutConstant.fixedUserImageSize,
                           height: UserLayoutConstant.fixedUserImageSize)
                    .clipShape(.rect(cornerRadius: 20))
            case .embeddedAsset(let string):
                Image(string)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UserLayoutConstant.fixedUserImageSize,
                           height: UserLayoutConstant.fixedUserImageSize)
                    .clipShape(.rect(cornerRadius: 20))
            }

            HStack {
                Image(systemName:  self.userPhoto.isLikedByUser ? "heart.fill" : "heart")
                    .onTapGesture {
                        Task {await self.likeOrDislikePhoto() }
                    }
                Spacer()
                Label("\(userPhoto.chatThread.messages.count)", systemImage: "message")
            }
            .font(.caption)
            .foregroundStyle(.gray)
        }
        .padding(.horizontal)
        .overlay(alignment: .center, content: {
            if self.userPhoto.isLikedByUser && self.showLikeAction {
                Image(systemName: "heart.fill").onAppear {
                    Task { await self.removeAnimatedLike() }
                }
            } else if !self.userPhoto.isLikedByUser && self.showLikeAction {
                Image(systemName: "heart").onAppear {
                    Task { await self.removeAnimatedLike() }
                }
            }
        })
        .onTapGesture(count: 2, perform: {
            Task { await self.likeOrDislikePhoto() }
        })
        .onTapGesture {
            withAnimation {
                self.photoToDisplayFullScreen = self.savedImage
            }
        }
    }
}

private extension UserItemView {
    private func likeOrDislikePhoto() async {
        if self.userPhoto.isLikedByUser {
            let dislikedPhoto = await self.allPhotosService.dislike(photo: self.userPhoto)
            self.userPhoto = SharedPhoto(imageDTO: dislikedPhoto, chatThread: self.userPhoto.chatThread)
            withAnimation {
                self.showLikeAction = true
            }
        } else {
            let photoLiked = await self.allPhotosService.like(photo: self.userPhoto)
            self.userPhoto = SharedPhoto(imageDTO: photoLiked, chatThread: self.userPhoto.chatThread)
            withAnimation {
                self.showLikeAction = true
            }
        }
    }

    private func removeAnimatedLike() async {
        do {
            try await Task.sleep(for: .seconds(1))
            withAnimation {
                self.showLikeAction = false
            }
        } catch {
            self.showLikeAction = false
        }
    }
}
