//
//  TodayDetailsViewModelOutput.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine

protocol TodayDetailsViewModelOutputable {
    var reloadPhotosPublisher: AnyPublisher<Void, Never> { get }
    var footerViewModelPublisher: AnyPublisher<TodayDetailsCollectionViewFooterSectionSupplementaryViewModelable, TodayDetailsViewModel.ViewModelError> { get }
}

struct TodayDetailsViewModelOutput: TodayDetailsViewModelOutputable {
    let reloadPhotosPublisher: AnyPublisher<Void, Never>
    let footerViewModelPublisher: AnyPublisher<TodayDetailsCollectionViewFooterSectionSupplementaryViewModelable, TodayDetailsViewModel.ViewModelError>
}
