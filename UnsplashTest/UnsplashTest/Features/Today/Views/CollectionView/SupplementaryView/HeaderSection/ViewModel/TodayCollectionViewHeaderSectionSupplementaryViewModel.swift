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
    let todayDateString: String
    let title: String = "Today"

    private let date: Date

    init(date: Date = Date()) {
        self.date = date
        self.todayDateString = Self.formatTodayDate(from: date).uppercased()
    }

    private static func formatTodayDate(from todayDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMMM"
        return dateFormatter.string(from: todayDate)
    }
}
