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
            let stringUrls = await imageService.getPhotos(for: 1)
            let urls = stringUrls.map { $0.urls.regular }.map { URL(string: $0)! }
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

#Preview {
    FeedView()
}
