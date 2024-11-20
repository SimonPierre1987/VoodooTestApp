//
//  SinglePhotoDownloader.swift
//  New Apps Test
//
//  Created by Pierre Simon on 20/11/2024.
//

import Foundation
import SwiftUI

typealias PhotoIdentifier = String

final actor SinglePhotoDownloader {
    // MARK: - Caching
    private enum CacheEntry {
        case inProgress(Task<Image?, Never>)
        case ready(Image?)
    }

    private var cache: [PhotoIdentifier: CacheEntry] = [:]

    // MARK: - PhotosDownloaderProtocol
    func image(for photo: SharedPhoto) async -> Image? {
        if let cachedPhotos = self.cache[photo.photoId] {
            switch cachedPhotos {
            case .inProgress(let task):
                return await task.value
            case .ready(let photos):
                return photos
            }
        }

        let task = Task {
            return await self.getImage(for: photo)
        }

        self.cache[photo.photoId] = .inProgress(task)

        let photos = await task.value
        self.cache[photo.photoId] = .ready(photos)
        return photos
    }
}

private extension SinglePhotoDownloader {
    private func getImage(for photo: SharedPhoto) async -> Image? {
            if let image = photo.contentSource.image {
                return image
            } else if let imageUrl = photo.contentSource.imageUrl {
                do {
                    let (data, _) = try await URLSession.shared.data(from: imageUrl)
                    if let image = UIImage(data: data) {
                        return Image(uiImage: image)
                    } else {
                        return nil
                    }
                } catch {
                    return nil
                }
            } else {
                return nil
            }
    }
}
