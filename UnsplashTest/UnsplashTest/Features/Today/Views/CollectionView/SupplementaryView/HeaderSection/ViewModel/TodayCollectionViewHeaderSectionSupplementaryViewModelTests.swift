//
//  TodayCollectionViewHeaderSectionSupplementaryViewModelTests.swift
//  UnsplashTestTests
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import XCTest
@testable import UnsplashTest

final class TodayCollectionViewHeaderSectionSupplementaryViewModelTests: XCTestCase {

    func test_title() {
        // GIVEN
        let viewModel = TodayCollectionViewHeaderSectionSupplementaryViewModel()

        // WHEN
        let title = viewModel.title

        // THEN
        XCTAssertEqual(title, "Today")
    }

    func test_todayDateString() {
        // GIVEN
        let date = Date(string: "2022-05-19")
        let viewModel = TodayCollectionViewHeaderSectionSupplementaryViewModel(date: date)

        // WHEN
        let todayDateString = viewModel.todayDateString

        // THEN
        XCTAssertEqual(todayDateString, "THURSDAY 19 MAY")
    }
}

private extension Date {

    init(string: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        self.init()
        self = formatter.date(from: string) ?? Date()
    }
}

