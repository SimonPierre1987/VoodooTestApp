//
//  FeedViewModel.swift
//  New Apps Test
//
//  Created by Pierre Simon on 20/11/2024.
//

import SwiftUI

@Observable
final class FeedViewModel {
    var allFeedPhotos: [PhotoEntity] = []
    var lastDisplayedPhoto: PhotoEntity?
    var photoToNavigate: PhotoEntity?
    var selectedUser: UserEntity?
    var goToShareAPhoto: Bool = false
}
