//
//  PhotosDownloader.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation

typealias Page = Int

protocol PhotosDownloaderProtocol {
    func photos(for page: Page) async throws -> [ImageDTO]
}

final actor PhotosDownloader: PhotosDownloaderProtocol {
    // MARK: - Services
    private let photosService: any UnsplashServiceProtocol

    // MARK: - Caching
    private enum CacheEntry {
        case inProgress(Task<[ImageDTO], Never>)
        case ready([ImageDTO])
    }

    private var cache: [Page: CacheEntry] = [:]

    // MARK: - Life Cycle
    init(photosService: any UnsplashServiceProtocol = UnsplashService()) {
        self.photosService = photosService
    }

    // MARK: - PhotosDownloaderProtocol
    func photos(for page: Page) async -> [ImageDTO] {
        if let cachedPhotos = self.cache[page] {
            switch cachedPhotos {
            case .inProgress(let task):
                return await task.value
            case .ready(let photos):
                return photos
            }
        }

        let task = Task {
            return await self.photosService.getPhotos(for: page)
        }

        self.cache[page] = .inProgress(task)

        let photos = await task.value
        self.cache[page] = .ready(photos)
        return photos
    }
}
