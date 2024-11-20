//
//  LikeOrDislikeModifier.swift
//  New Apps Test
//
//  Created by Pierre Simon on 20/11/2024.
//

import SwiftUI

extension View {
    func likeOrDislikePhoto(photo: Binding<SharedPhoto>, showLikeAction: Binding<Bool>, size: CGFloat) -> some View {
        modifier(LikeOrDislikeModifier(size: size, photo: photo, showLikeAction: showLikeAction))
    }
}

struct LikeOrDislikeModifier: ViewModifier {
    // MARK: Services
    let allPhotosService = AllPhotosService()

    // MARK: - Geometry
    let size: CGFloat

    // MARK: - State
    @Binding var photo: SharedPhoto
    @Binding var showLikeAction: Bool

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .center, content: {
                if self.photo.isLikedByUser && self.showLikeAction {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .foregroundStyle(Color.red)
                        .frame(width: self.size, height: self.size, alignment: .center)
                        .task { await self.removeAnimatedLike() }
                } else if !self.photo.isLikedByUser && self.showLikeAction {
                    Image(systemName: "heart")
                        .resizable()
                        .foregroundStyle(Color.black)
                        .frame(width: self.size, height: self.size, alignment: .center)
                        .task { await self.removeAnimatedLike() }
                }
            })
            .onTapGesture(count: 2, perform: {
                Task { await self.likeOrDislikePhoto() }
            })
    }
}

private extension LikeOrDislikeModifier {
    private func likeOrDislikePhoto() async {
        if self.photo.isLikedByUser {
            // On purpose I don't wait for the backend to satisfy the user visually.
            // It's an optimistic behavior. Most of the time the backend will be satisfying the user desire (about likes)
            // If the backend fails, the visual state will be reset and not corrupted
            self.photo.isLikedByUser = false
            withAnimation {
                self.showLikeAction = true
            }
            let dislikedPhoto = await self.allPhotosService.dislike(photo: self.photo)
            self.photo.isLikedByUser = dislikedPhoto.likedByUser ?? false
        } else {
            // On purpose I don't wait for the backend to satisfy the user visually.
            // It's an optimistic behavior. Most of the time the backend will be satisfying the user desire (about likes)
            // if the backend fails, the visual state will be reset and not corrupted
            self.photo.isLikedByUser = true
            withAnimation {
                self.showLikeAction = true
            }
            let photoLiked = await self.allPhotosService.like(photo: self.photo)
            self.photo.isLikedByUser = photoLiked.likedByUser ?? false
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

