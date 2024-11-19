//
//  UserItemView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation
import SwiftUI

struct UserItemView: View {
    let sharedPhoto: SharedPhoto

    // MARK: - States
    @State var savedImage: Image?
    @Binding var photoToDisplayFullScreen: Image?

    var body: some View {
        VStack {
            switch sharedPhoto.contentSource {
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
                Spacer()
                Label("\(sharedPhoto.chatThread.messages.count)", systemImage: "message")
            }
            .font(.caption)
            .foregroundStyle(.gray)
        }
        .padding(.horizontal)
        .onTapGesture {
            withAnimation {
                self.photoToDisplayFullScreen = self.savedImage
            }
        }
    }
}
