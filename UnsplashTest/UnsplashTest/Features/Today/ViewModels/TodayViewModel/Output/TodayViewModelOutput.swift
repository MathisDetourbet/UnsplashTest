//
//  TodayViewModelOutput.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine

protocol TodayViewModelOutputable {
    var reloadPhotosPublisher: AnyPublisher<Void, Never> { get }
    var headerViewModel: TodayCollectionViewHeaderSectionSupplementaryViewModel { get }
}

struct TodayViewModelOutput: TodayViewModelOutputable {
    let reloadPhotosPublisher: AnyPublisher<Void, Never>
    let headerViewModel: TodayCollectionViewHeaderSectionSupplementaryViewModel
}
