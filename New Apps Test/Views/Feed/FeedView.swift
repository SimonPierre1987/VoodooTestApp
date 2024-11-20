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

@Observable
final class FeedViewModel {
    var allFeedPhotos: [SharedPhoto] = []
}

struct FeedView: View {
    // MARK: - Services
    private let photosDownloader = PhotosDownloader()
    private let singlePhotoDownloader = SinglePhotoDownloader()
    private let chatThread = Thread.mock

    // MARK: - States
    @State var feedViewModel = FeedViewModel()
    @State var lastDisplayedPhoto: SharedPhoto?
    @State var selectedUser: UserEntity?

    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: self.$navigationPath) {
            ScrollView {
                LazyVStack {
                    self.listHeaderView

                    ForEach(self.$feedViewModel.allFeedPhotos, id: \.self) { feedPhoto in
                        FeedItemView(
                            singlePhotoDownloader: self.singlePhotoDownloader,
                            feedPhoto: feedPhoto,
                            lastDisplayedPhoto: self.$lastDisplayedPhoto,
                            selectedUser: self.$selectedUser
                        )
                        .padding(.bottom)
                    }
                }
                .padding()
                .navigationDestination(for: SharedPhoto.self) { feedPhoto in
                    ThreadChatView(thread: self.chatThread)
                }
                .navigationDestination(for: UserEntity.self) { user in
                    UserProfileView(user: user, singlePhotoDownloader: self.singlePhotoDownloader)
                }
            }
        }
        .onChange(of: self.selectedUser, { oldValue, newValue in
            guard let selectedUser else { return }
            self.navigationPath.append(selectedUser)
            self.selectedUser = nil
        })
        .onChange(of: self.lastDisplayedPhoto, { oldValue, newValue in
            guard let lastDisplayedPhoto = newValue else { return }
            guard let photoIndex = self.feedViewModel.allFeedPhotos.firstIndex(of: lastDisplayedPhoto) else { return }

            Task { await self.fetchNextPage(for: photoIndex) }
        })
        .task { await self.fetch(nextPage: 1) }
    }
}

// MARK: - Pages to fetch
private extension FeedView {
    private func fetchNextPage(for photoIndex: Int) async {
        guard let page = self.nextPageToLoad(for: photoIndex) else { return }
        await self.fetch(nextPage: page)
    }

    private func fetch(nextPage: Page) async {
        let newPhotos = await self.photosDownloader.photos(for: nextPage)
        let newFeedPhotos = newPhotos.toSharedPhoto()
        self.feedViewModel.allFeedPhotos.append(contentsOf: newFeedPhotos)
    }

    private func nextPageToLoad(for photoIndex: Int) -> Page? {
        if !self.shouldFetchNextPage(for: photoIndex) { return nil }
        if FeedConstant.photosPerPage == 0 { return nil }
        let page = (photoIndex + FeedConstant.nextPhotoThreshold) / FeedConstant.photosPerPage
        let nextPage = page + 1
        return nextPage
    }

    private func shouldFetchNextPage(for photoIndex: Int) -> Bool {
        return photoIndex == self.feedViewModel.allFeedPhotos.count - FeedConstant.nextPhotoThreshold
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
                    let newCurrentUserPhoto = SharedPhoto(
                        photoId: UUID().uuidString,
                        author: UserEntity.currentUser,
                        contentSource: .image(image),
                        description: nil,
                        isLikedByUser: false,
                        likes: 0
                    )
                    self.feedViewModel.allFeedPhotos.insert(newCurrentUserPhoto, at: 0)
                    // TODO: Post the image.
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
