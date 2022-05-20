//
//  TodayDetailsCollectionViewFooterSectionSupplementaryViewModelTests.swift
//  UnsplashTestTests
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import XCTest
import Combine
@testable import UnsplashTest

final class TodayDetailsCollectionViewFooterSectionSupplementaryViewModelTests: XCTestCase {

    func test_title() {
        // GIVEN
        let viewModel = TodayDetailsCollectionViewFooterSectionSupplementaryViewModel(
            viewsCountPublisher: Empty().eraseToAnyPublisher(),
            downloadsCountPublisher: Empty().eraseToAnyPublisher()
        )

        // WHEN
        let title = viewModel.title

        // THEN
        XCTAssertEqual(title, "Picture Statistics")
    }

    func test_viewsCountStringPublisher() throws {
        // GIVEN
        let viewModel = TodayDetailsCollectionViewFooterSectionSupplementaryViewModel(
            viewsCountPublisher: Just(24).eraseToAnyPublisher(),
            downloadsCountPublisher: Empty().eraseToAnyPublisher()
        )

        // WHEN
        let viewsCountString = try self.awaitValue(from: viewModel.viewsCountStringPublisher)

        // THEN
        XCTAssertEqual(viewsCountString, "24 views")
    }

    func test_downloadsCountStringPublisher() throws {
        // GIVEN
        let viewModel = TodayDetailsCollectionViewFooterSectionSupplementaryViewModel(
            viewsCountPublisher: Empty().eraseToAnyPublisher(),
            downloadsCountPublisher: Just(432).eraseToAnyPublisher()
        )

        // WHEN
        let downloadsCountString = try self.awaitValue(from: viewModel.downloadsCountStringPublisher)

        // THEN
        XCTAssertEqual(downloadsCountString, "432 downloads")
    }
}
