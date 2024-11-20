//
//  UserProfilePictureView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import SwiftUI

struct UserProfilePictureView: View {
    private let user: UserEntity
    private let profileSize: UserProfileViewSize

    private var userProfileUrl: URL?

    @Binding var selectedUser: UserEntity?

    init(user: UserEntity,
         profileSize: UserProfileViewSize,
         selectedUser: Binding<UserEntity?>? = nil) {
        self.user = user
        self.profileSize = profileSize

        self._selectedUser = selectedUser ?? Binding.constant(nil)

        switch self.profileSize {
        case .small:
            self.userProfileUrl = self.user.profileImage.smallUrl
        case .medium:
            self.userProfileUrl = self.user.profileImage.mediumUrl
        case .large:
            self.userProfileUrl = self.user.profileImage.largeUrl
        }
    }

    var body: some View {
        AsyncImage(
            url: self.userProfileUrl,
            content: { image in  image.resizable().aspectRatio(contentMode: .fit) },
            placeholder: { ProgressView().progressViewStyle(.circular) })
        .frame(width: self.profileSize.width, height: self.profileSize.height)
        .clipShape(.rect(cornerRadius: self.profileSize.width))
        .overlay(
            RoundedRectangle(cornerRadius: self.profileSize.width)
                .stroke(.white, lineWidth: 2)
        )
        .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
        .onTapGesture {
            self.selectedUser = self.user
        }
    }
}
