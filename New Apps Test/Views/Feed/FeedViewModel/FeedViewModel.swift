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
    var selectedUser: UserEntity?
}
