//
//  TodayDetailsCollectionViewFooterSectionSupplementaryViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation
import Combine

protocol TodayDetailsCollectionViewFooterSectionSupplementaryViewModelable {
    var title: String { get }
    var viewsCountStringPublisher: AnyPublisher<String, Never> { get }
    var downloadsCountStringPublisher: AnyPublisher<String, Never> { get }
}

final class TodayDetailsCollectionViewFooterSectionSupplementaryViewModel: TodayDetailsCollectionViewFooterSectionSupplementaryViewModelable {
    let title: String = "Picture Statistics"
    let viewsCountStringPublisher: AnyPublisher<String, Never>
    let downloadsCountStringPublisher: AnyPublisher<String, Never>

    init(
        viewsCountPublisher: AnyPublisher<Int, Never>,
        downloadsCountPublisher: AnyPublisher<Int, Never>
    ) {
        self.viewsCountStringPublisher = viewsCountPublisher
            .map(Self.calculateViewsCountString(from:))
            .eraseToAnyPublisher()

        self.downloadsCountStringPublisher = downloadsCountPublisher
            .map(Self.calculateDownloadsCountString(from:))
            .eraseToAnyPublisher()
    }

    private static func calculateViewsCountString(from viewsCount: Int) -> String {
        return "\(viewsCount) views"
    }

    private static func calculateDownloadsCountString(from downloadsCount: Int) -> String {
        return "\(downloadsCount) downloads"
    }
}
