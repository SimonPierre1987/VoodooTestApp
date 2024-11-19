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

final class UnsplashService {
    private let appId = "575727"
    private let networkManager = NetworkManager()

    func getPhotos(for page: Int) async -> [ImageInfo] {
        do {
            let endpoint = UnsplashAPIEndpoint.photo(page: page, countPerPage: 20)
            return try await self.networkManager.performRequest(with: endpoint)
        } catch {
            return []
        }
    }
}
