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

    // MARK: State
    @State var sharedPhotos: [SharedPhoto] = []
    @State var userPhotosAlreadyFetched = false
    @State var photoToDisplayFullScreen: Image?

    // MARK: - Layout
    let column = [
        GridItem(.fixed(UserLayoutConstant.fixedUserImageSize)),
        GridItem(.fixed(UserLayoutConstant.fixedUserImageSize)),
        GridItem(.fixed(UserLayoutConstant.fixedUserImageSize))
    ]

    var body: some View {
        VStack(spacing: 0) {
            UserProfilePictureView(user: self.user, profileSize: .large)
            UserNameView(firstName: self.user.firstName,
                         lastName: self.user.lastName)
            UserBioView(bio: self.user.bio)
            ScrollView {
                LazyVGrid(columns: self.column, spacing: 0) {
                    ForEach(self.sharedPhotos, id: \.self) { sharedPhoto in
                        UserItemView(
                            sharedPhoto: sharedPhoto,
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
            self.sharedPhotos = userPhotos
                .map { SharedPhoto(imageInfo: $0, chatThread: Thread.mock )}
            self.userPhotosAlreadyFetched = true
        } catch {
            // Nothing to do
        }
    }
}

#Preview {
    UserProfileView(user: UserEntity.mockOne)
}
