//
//  TodayDetailsViewModelOutput.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine

protocol TodayDetailsViewModelOutputable {
    var reloadPhotosPublisher: AnyPublisher<Void, Never> { get }
    var footerViewModel: TodayDetailsCollectionViewFooterSectionSupplementaryViewModelable { get }
}

struct TodayDetailsViewModelOutput: TodayDetailsViewModelOutputable {
    let reloadPhotosPublisher: AnyPublisher<Void, Never>
    let footerViewModel: TodayDetailsCollectionViewFooterSectionSupplementaryViewModelable
}
