//
//  UnsplashService.swift
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

import Foundation
import OSLog

protocol AllPhotosServiceProtocol {
    func getPhotos(for page: Int) async -> [ImageDTO]
}

final class AllPhotosService: AllPhotosServiceProtocol {
    private let networkManager = NetworkManager()

    func getPhotos(for page: Int) async -> [ImageDTO] {
        do {
            let endpoint = UnsplashAPIEndpoint.photo(page: page, countPerPage: FeedConstant.photosPerPage)
            return try await self.networkManager.performRequest(with: endpoint)
        } catch {
            return []
        }
    }

    func like(photo: SharedPhoto) async -> ImageDTO {
        do {
            let endpoint = UnsplashAPIEndpoint.like(photoId: photo.photoId)
            return try await self.networkManager.performRequest(with: endpoint)
        } catch {
            // DISCLAIMER: The endpoint will not work as I dont have an account for this client_id and I don''t succeed to set up an account.
            // If I was successful, the documentation is asking to set up the "write_likes" scope for the account in order to use this service.
            // Meanwhile i will fake a positive answer from the back-end.
            // The photo will be updated accordingly locally.
            // Only the like/dislike will not be visible each time we fetch this photo again.
            Logger.appLog.error("Please read the disclaimers of AllPhotosService")
            return SharedPhoto.toImageDTO(sharedPhoto: photo, isLikedByUser: true)
        }
    }

    func dislike(photo: SharedPhoto) async -> ImageDTO {
        do {
            let endpoint = UnsplashAPIEndpoint.dislike(photoId: photo.photoId)
            return try await self.networkManager.performRequest(with: endpoint)
        } catch {
            // DISCLAIMER: The endpoint will not work as I dont have an account for this client_id and I don''t succeed to set up an account.
            // If I was successful, the documentation is asking to set up the "write_likes" scope for the account in order to use this service.
            // Meanwhile i will fake a positive answer from the back-end.
            // The photo will be updated accordingly locally.
            // Only the like/dislike will not be visible each time we fetch this photo again.
            Logger.appLog.error("Please read the disclaimers of AllPhotosService")
            return SharedPhoto.toImageDTO(sharedPhoto: photo, isLikedByUser: false)
        }
    }
}
