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

    init(user: UserEntity, profileSize: UserProfileViewSize) {
        self.user = user
        self.profileSize = profileSize
    
        switch self.profileSize {
        case .small:
            self.userProfileUrl = URL(string:self.user.profileImage.small)
        case .medium:
            self.userProfileUrl = URL(string:self.user.profileImage.medium)
        case .large:
            self.userProfileUrl = URL(string:self.user.profileImage.large)
        }
    }

    var body: some View {
        AsyncImage(
            url: self.userProfileUrl,
            content: { image in  image },
            placeholder: { ProgressView().progressViewStyle(.circular) })
        .frame(width: self.profileSize.width, height: self.profileSize.height)
        .clipShape(.rect(cornerRadius: self.profileSize.width))
        .overlay(
            RoundedRectangle(cornerRadius: self.profileSize.width)
                .stroke(.white, lineWidth: 2)
        )
        .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
    }
}
