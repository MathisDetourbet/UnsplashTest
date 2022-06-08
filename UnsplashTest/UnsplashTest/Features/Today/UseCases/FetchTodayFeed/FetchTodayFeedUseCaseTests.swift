//
//  FetchTodayFeedUseCaseTests.swift
//  UnsplashTestTests
//
//  Created by Mathis DETOURBET on 21/05/2022.
//

import XCTest
import Combine
@testable import UnsplashTest

final class FetchTodayFeedUseCaseTests: XCTestCase {

    func test_execute_should_success() throws {
        // GIVEN
        let successRepositoryMock = MockSuccessPhotosRepository()

        // WHEN
        let photosPublisher = successRepositoryMock.getPhotos()

        // THEN
        let photos = try self.awaitValue(from: photosPublisher)
        XCTAssertEqual(photos.count, 10)
    }

    func test_execute_should_fail() throws {
        // GIVEN
        let failureRepositoryMock = MockFailurePhotosRepository()

        // WHEN
        let photosPublisher = failureRepositoryMock.getPhotos()

        // THEN
        let error = try self.awaitFailure(from: photosPublisher)
        XCTAssertEqual(error, .badRequest)
    }
}

private final class MockSuccessPhotosRepository: PhotosRepositoryProtocol {

    func getPhotos() -> AnyPublisher<[PhotoEntity], RepositoryError> {
        let photos: [PhotoEntity] = Array(repeating: photoEntity, count: 10)
        return Just(photos).setFailureType(to: RepositoryError.self).eraseToAnyPublisher()
    }
}

private final class MockFailurePhotosRepository: PhotosRepositoryProtocol {

    func getPhotos() -> AnyPublisher<[PhotoEntity], RepositoryError> {
        return Fail(error: RepositoryError.badRequest).eraseToAnyPublisher()
    }
}

private let photoEntity: PhotoEntity = {
    let profileImageEntity = UserEntity.ProfileImageEntity(from: .init(small: "https://google.com"))
    let userEntity = UserEntity(id: "2", username: "Doe", profileImageEntity: profileImageEntity)
    let photoEntity = PhotoEntity(id: "1", description: "image description", imageURL: .init(string: "https://google.com"), userEntity: userEntity, likesCount: 24)
    return photoEntity
}()
