//
//  NetworkManager.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation

final class NetworkManager {
    func performRequest<T: Decodable>(with endpoint: Endpoint) async throws -> T   {
        guard let request = endpoint.createURLRequest() else {
            throw UnsplashError.incorrectUrl
        }

        return try await self.performUrlRequest(request)
    }

  private func performUrlRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            let result = try await URLSession.shared.data(for: request)

            guard let urlResponse = result.1 as? HTTPURLResponse, 200...299 ~= urlResponse.statusCode else {
                throw UnsplashError.serverError(result.1)
            }

            return try self.decodedData(result.0)
        } catch {
            throw UnsplashError.clientError(error)
        }
    }

    private func decodedData<T: Decodable>(_ data: Data) throws -> T {
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw UnsplashError.dataDecodingError
        }
    }
}

