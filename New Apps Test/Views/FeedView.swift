//
//  ContentView.swift
//  New Apps Test
//
//  Created by Michel-André Chirita on 06/03/2024.
//

/*
 --------------------------------------------------
 -- Voodoo New Apps Tech Test
 -- BOOSTRAP FILE
 -- Feel free to modify or dismiss it as you like !
 --------------------------------------------------
 */

import SwiftUI

struct FeedView: View {

    var imageService = UnsplashService()
    @State var sharedPhotos: [SharedPhoto] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    listHeaderView

                    ForEach(sharedPhotos, id: \.self) { sharedPhoto in
                        NavigationLink(value: sharedPhoto) {
                            FeedItemView(sharedPhoto: sharedPhoto)
                                .padding(.bottom)
                        }
                    }
                }
                .padding()
                .navigationDestination(for: SharedPhoto.self) { sharedPhoto in
                    ThreadChatView(thread: sharedPhoto.chatThread)
                }
            }
        }
        .task {
            let stringUrls = await imageService.getFeaturedPhotos()
            let urls = stringUrls.map { URL(string: $0)! }
            sharedPhotos = urls.map { SharedPhoto(author: User.random, contentSource: .url($0), chatThread: Thread.mock) }
        }
    }

    @ViewBuilder
    private var listHeaderView: some View {
        HStack {
            Spacer()

            NavigationLink {
                SharePhotoView { image in
                    sharedPhotos.append(SharedPhoto(author: User.mockUser1, contentSource: .image(image), chatThread: Thread()))
                }
            } label: {
                Image(systemName: "plus")
                    .font(.title)
            }
        }
        .padding()
    }
}

struct FeedItemView: View {

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
                Text("Photo shared by " + sharedPhoto.author.name)
                Spacer()
                Label("\(sharedPhoto.chatThread.messages.count) messages", systemImage: "message")
            }
            .font(.caption)
            .foregroundStyle(.gray)
        }
        .padding(.horizontal)
    }
}

#Preview {
    FeedView()
}
