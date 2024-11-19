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

    var body: some View {
        VStack {
            switch sharedPhoto.contentSource {
            case .url(let url):
                AsyncImage(url: url)
                    .frame(width: 350, height: 300)
                    .clipShape(.rect(cornerRadius: 20))
            case .image(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 300)
                    .clipShape(.rect(cornerRadius: 20))
            case .embeddedAsset(let string):
                Image(string)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 300)
                    .clipShape(.rect(cornerRadius: 20))
            }

            HStack {
                Text("Photo shared by " + sharedPhoto.author.firstName)
                Spacer()
                Label("\(sharedPhoto.chatThread.messages.count) messages", systemImage: "message")
            }
            .font(.caption)
            .foregroundStyle(.gray)
        }
        .padding(.horizontal)
    }
}
