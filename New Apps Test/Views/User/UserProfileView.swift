//
//  UserProfileView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation
import SwiftUI

enum UserLayoutConstant {
    static let margin: CGFloat = 15
}

struct UserProfileView: View {
    let user: UserEntity

    // MARK: - Services
    private let userService: UserService = UserService()

    // MARK: State
    @State var sharedPhotos: [SharedPhoto] = []


    var body: some View {
        VStack(spacing: 0) {
            UserProfilePictureView(user: self.user, profileSize: .large)
            UserNameView(firstName: self.user.firstName,
                         lastName: self.user.lastName)
            UserBioView(bio: self.user.bio)
        }
        ScrollView {
            LazyVStack {
                ForEach(self.sharedPhotos, id: \.self) { sharedPhoto in
                    NavigationLink(value: sharedPhoto) {
                        UserItemView(sharedPhoto: sharedPhoto)
                            .padding(.bottom)
                    }
                }
            }
            .padding()
        }

        .onAppear(perform: {
            Task {
                do {
                    let userPhotos = try await self.userService.getPhotos(for: self.user.username )
                    self.sharedPhotos = userPhotos.map { SharedPhoto(imageInfo: $0, chatThread: Thread.mock )}
                } catch {
                    fatalError()
                }
            }
        })

    }
}

#Preview {
    UserProfileView(user: UserEntity.mockOne)
}

struct UserBioView: View {
    let bio: String?
    var body: some View {
        Text(self.bio ?? "")
            .font(.caption2)
            .opacity(self.bio == nil ? 0 : 1)
            .padding(
                EdgeInsets(top: 0, leading: UserLayoutConstant.margin,
                           bottom: 0,
                           trailing: UserLayoutConstant.margin
                          )
            )
    }
}

struct UserNameView: View {
    let firstName: String
    let lastName: String

    var body: some View {
        Text(self.firstName + " " + self.lastName)
            .font(.title)
            .padding(
            EdgeInsets(top: 0, leading: UserLayoutConstant.margin,
                       bottom: 0,
                       trailing: UserLayoutConstant.margin
                      )
        )
    }
}
