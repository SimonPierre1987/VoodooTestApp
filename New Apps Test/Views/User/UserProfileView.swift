//
//  UserProfileView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation
import SwiftUI

struct UserProfileView: View {
    let user: UserEntity

    // MARK: - Services
    private let userService: UserService = UserService()
    let singlePhotoDownloader: SinglePhotoDownloader

    // MARK: State
    @State var usersPhotos: [PhotoEntity] = []
    @State var userPhotosAlreadyFetched = false
    @State var photoToDisplayFullScreen: Image?

    // MARK: - Layout
    let column = [
        GridItem(.fixed(UserLayoutConstant.fixedUserImageSize)),
        GridItem(.fixed(UserLayoutConstant.fixedUserImageSize)),
        GridItem(.fixed(UserLayoutConstant.fixedUserImageSize))
    ]

    // MARK: - Life cycle
    var body: some View {
        VStack(spacing: 0) {
            UserProfilePictureView(user: self.user, profileSize: .large)
            UserNameView(firstName: self.user.firstName,
                         lastName: self.user.lastName)
            UserBioView(bio: self.user.bio)
            Spacer(minLength: UserLayoutConstant.margin)
            ScrollView {
                LazyVGrid(columns: self.column, spacing: 0) {
                    ForEach(self.usersPhotos, id: \.self) { userPhoto in
                        UserItemView(
                            singlePhotoDownloader: self.singlePhotoDownloader,
                            userPhoto: userPhoto,
                            photoToDisplayFullScreen: self.$photoToDisplayFullScreen)
                        .padding(.bottom)
                    }
                }
                .padding()
            }
            .overlay(alignment: .center) {
                if let photoToDisplayFullScreen = self.photoToDisplayFullScreen {
                    FullSizePhotoView(
                        image: photoToDisplayFullScreen,
                        photoToDisplayFullScreen: self.$photoToDisplayFullScreen)
                    .transition(.asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top)))
                }
            }
        }
        .task {
            await self.fetchUserPhotosIfNeeded()
        }
    }
}

private extension UserProfileView {
    private func fetchUserPhotosIfNeeded() async {
        if self.userPhotosAlreadyFetched { return }
        do {
            let userPhotos = try await self.userService.getPhotos(for: self.user.username )
            self.usersPhotos = userPhotos
                .map { PhotoEntity(imageDTO: $0)}
            self.userPhotosAlreadyFetched = true
        } catch {
            // Nothing to do
        }
    }
}

#Preview {
    UserProfileView(user: UserEntity.currentUser, singlePhotoDownloader: SinglePhotoDownloader())
}
