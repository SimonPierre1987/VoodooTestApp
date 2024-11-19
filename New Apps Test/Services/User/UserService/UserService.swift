//
//  UserService.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation

protocol UserServiceProtocl {
    func getPublicProfile(for userName: String) async throws -> UserDTO
    func getCurrentUser() async throws -> UserDTO
}

final class UserService: UserServiceProtocl {
    private let networkManager = NetworkManager()

    func getPublicProfile(for userName: String) async throws -> UserDTO {
        let endpoint = UnsplashAPIEndpoint.user(userName: userName)
        return try await self.networkManager.performRequest(with: endpoint)
    }

    func getCurrentUser() async throws -> UserDTO {
        let endpoint = UnsplashAPIEndpoint.me
        return try await self.networkManager.performRequest(with: endpoint)
    }

    func getPhotos(for userName: String) async throws -> [ImageDTO] {
        let endpoint = UnsplashAPIEndpoint.userPhotos(username: userName)
        return try await self.networkManager.performRequest(with: endpoint)
    }
}
