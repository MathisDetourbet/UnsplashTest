//
//  TodayCollectionViewHeaderSectionSupplementaryViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import Foundation

protocol TodayCollectionViewHeaderSectionSupplementaryViewModelable {
    var todayDateString: String { get }
    var title: String { get }
}

struct TodayCollectionViewHeaderSectionSupplementaryViewModel: TodayCollectionViewHeaderSectionSupplementaryViewModelable {
    let todayDateString: String = Self.formatTodayDate().uppercased()
    let title: String = "Today"

    private let date: Date

    init(date: Date = Date()) {
        self.date = date
    }

    private static func formatTodayDate() -> String {
        let todayDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMMM"
        return dateFormatter.string(from: todayDate)
    }
}
