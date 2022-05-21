//
//  PhotoViewModelTests.swift
//  UnsplashTestTests
//
//  Created by Mathis DETOURBET on 21/05/2022.
//

import XCTest
@testable import UnsplashTest

final class PhotoViewModelTests: XCTestCase {

    func test_init() {
        // GIVEN
        let profileImageEntity = UserEntity.ProfileImageEntity(from: .init(small: "https://google.com"))
        let userEntity = UserEntity(id: "2", username: "Doe", profileImageEntity: profileImageEntity)
        let photoEntity = PhotoEntity(id: "1", description: "image description", imageURL: .init(string: "https://google.com"), userEntity: userEntity, likesCount: 24)
        let viewModel = PhotoViewModel(entity: photoEntity)

        // THEN
        XCTAssertEqual(viewModel.photoId, "1")
        XCTAssertEqual(viewModel.backgroundImageURL, URL(string: "https://google.com"))
        XCTAssertEqual(viewModel.userImageURL, URL(string: "https://google.com"))
        XCTAssertEqual(viewModel.description, "image description")
        XCTAssertEqual(viewModel.username, "Doe")
        XCTAssertEqual(viewModel.likesCountString, "24 likes")

    }
}
