//
//  PhotosDownloaderTests.swift
//  New Apps TestTests
//
//  Created by Pierre Simon on 21/11/2024.
//

import XCTest
@testable import New_Apps_Test

final class PhotosDownloaderTests: XCTestCase {
    func test_multiple_calls_case_1() async throws {
        let getPhotoExpectation = XCTestExpectation(description: "getPhotos is called")
        // Only one fetch should be done
        getPhotoExpectation.expectedFulfillmentCount = 1

        let allPhotoService = AllPhotosServiceSpy(expectation: getPhotoExpectation)
        let photosDownloader = PhotosDownloader(photosService: allPhotoService)

        // We launch 3 "parallel" fetches for the same page
        async let result1 = await photosDownloader.photos(for: 1)
        async let result2 = await photosDownloader.photos(for: 1)
        async let result3 = await photosDownloader.photos(for: 1)

        _ = await (result1, result2, result3)

        // Only one fetch should be done
        await fulfillment(of: [getPhotoExpectation], timeout: 0.3)
    }

    func test_multiple_calls_case_2() async throws {
        let getPhotoExpectation = XCTestExpectation(description: "getPhotos is called")
        // Two fetches are trigger (one for page 1, the other for page 2)
        getPhotoExpectation.expectedFulfillmentCount = 2

        let allPhotoService = AllPhotosServiceSpy(expectation: getPhotoExpectation)
        let photosDownloader = PhotosDownloader(photosService: allPhotoService)

        // We launch 3 "parallel" fetches for the page 1 and the page 2
        async let result1 = await photosDownloader.photos(for: 1)
        async let result2 = await photosDownloader.photos(for: 1)
        async let result3 = await photosDownloader.photos(for: 2)

        _ = await (result1, result2, result3)

        // Two fetches are trigger (one for page 1, the other for page 2)
        await fulfillment(of: [getPhotoExpectation], timeout: 0.3)
    }
}

private final class AllPhotosServiceSpy: AllPhotosServiceProtocol {
    let expectation: XCTestExpectation

    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }

    func getPhotos(for page: Int) async -> [New_Apps_Test.ImageDTO] {
        do {
            try await Task.sleep(for: .seconds(0.1))
            self.expectation.fulfill()
            return [] // the count is not important here. The tests are to demonstrate that the caching is effective.
        } catch {
            XCTFail("OS issue")
            return []
        }
    }
}
