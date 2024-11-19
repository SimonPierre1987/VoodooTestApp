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
    // MARK: - Services
    private let photoDownloader = PhotosDownloader()

    // MARK: - States
    @State var sharedPhotos: [SharedPhoto] = []
    @State var lastDisplayedPhoto: SharedPhoto?
    @State var selectedUser: UserEntity?

    @State private var navPath = NavigationPath()

    var body: some View {
        NavigationStack(path: self.$navPath) {
            ScrollView {
                LazyVStack {
                    self.listHeaderView

                    ForEach(sharedPhotos, id: \.self) { sharedPhoto in
                        NavigationLink(value: sharedPhoto) {
                            FeedItemView(
                                sharedPhoto: sharedPhoto,
                                lastDisplayedPhoto: self.$lastDisplayedPhoto,
                                selectedUser: self.$selectedUser
                            )
                            .padding(.bottom)
                        }
                    }
                }
                .padding()
                .navigationDestination(for: SharedPhoto.self) { sharedPhoto in
                    ThreadChatView(thread: sharedPhoto.chatThread)
                }
                .navigationDestination(for: UserEntity.self) { user in
                    UserProfileView(user: user)
                }
            }
        }
        .onChange(of: self.selectedUser, { oldValue, newValue in
            guard let selectedUser else { return }
            self.navPath.append(selectedUser)
            self.selectedUser = nil
        })
        .onChange(of: self.lastDisplayedPhoto, { oldValue, newValue in
            guard let lastDisplayedPhoto = newValue else { return }
            guard let photoIndex = self.sharedPhotos.firstIndex(of: lastDisplayedPhoto) else { return }

            Task { await self.fetchNextPage(for: photoIndex) }
        })
        .task {
            await self.fetch(nextPage: 1)
        }
    }
}

// MARK: - Pages to fetch
private extension FeedView {
    private func fetchNextPage(for photoIndex: Int) async {
        guard let page = self.nextPageToLoad(for: photoIndex) else { return }
        await self.fetch(nextPage: page)
    }

    private func fetch(nextPage: Page) async {
        let newPhotos = await self.photoDownloader.photos(for: nextPage)
        let newSharedPhotos = self.toSharedPhotos(photos: newPhotos)
        self.sharedPhotos.append(contentsOf: newSharedPhotos)
    }

    private func nextPageToLoad(for photoIndex: Int) -> Page? {
        if !self.shouldFetchNextPage(for: photoIndex) { return nil }
        if FeedConstant.photosPerPage == 0 { return nil }
        let page = (photoIndex + FeedConstant.nextPhotoThreshold) / FeedConstant.photosPerPage
        let nextPage = page + 1
        return nextPage
    }

    private func shouldFetchNextPage(for photoIndex: Int) -> Bool {
        return photoIndex == self.sharedPhotos.count - FeedConstant.nextPhotoThreshold
    }
}

// MARK: - Helpers
private extension FeedView {
    private func toSharedPhotos(photos: [ImageDTO]) -> [SharedPhoto] {
        return photos.map { SharedPhoto(imageInfo: $0, chatThread: Thread.mock) }
    }
}

// MARK: - Share Header View
private extension FeedView {
    @ViewBuilder
    private var listHeaderView: some View {
        HStack {
            Spacer()

            NavigationLink {
                SharePhotoView { image in
                    sharedPhotos.append(SharedPhoto(author: UserEntity.currentUser, contentSource: .image(image), chatThread: Thread()))
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
