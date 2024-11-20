//
//  LikeOrDislikeModifier.swift
//  New Apps Test
//
//  Created by Pierre Simon on 20/11/2024.
//

import SwiftUI

extension View {
    func likeOrDislikePhoto(photo: Binding<PhotoEntity>, showLikeAction: Binding<Bool>, size: CGFloat) -> some View {
        modifier(LikeOrDislikeModifier(size: size, photo: photo, showLikeAction: showLikeAction))
    }
}

struct LikeOrDislikeModifier: ViewModifier {
    // MARK: Services
    let allPhotosService = AllPhotosService()

    // MARK: - Geometry
    let size: CGFloat

    // MARK: - State
    @Binding var photo: PhotoEntity
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
                    Image(systemName: "heart.slash")
                        .resizable()
                        .foregroundStyle(Color.white)
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
        // On purpose I don't wait for the backend to satisfy the user visually.
        // It's an optimistic behavior. Most of the time the backend will be satisfying the user desire (about likes)
        // If the backend fails, the visual state will be reset and not corrupted
        self.updatePhoto(isLiked: !self.photo.isLikedByUser)

        withAnimation {
            self.showLikeAction = true
        }
        
        let updatePhoto = self.photo.isLikedByUser ?
        await self.allPhotosService.dislike(photo: self.photo) :
        await self.allPhotosService.like(photo: self.photo)

        self.photo.isLikedByUser = updatePhoto.likedByUser ?? false
        self.photo.likes = updatePhoto.likes ?? 0

    }

    private func updatePhoto(isLiked: Bool) {
        self.photo.isLikedByUser = isLiked
        self.photo.likes = isLiked ? self.photo.likes + 1 : self.photo.likes - 1
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

