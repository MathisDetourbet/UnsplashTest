//
//  TodayDetailsViewModelInput.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine

protocol TodayDetailsViewModelInputable {
    var username: String { get }
    var photoId: String { get }
    var viewEventPublisher: AnyPublisher<TodayDetailsViewEvent, Never> { get }
    var fetchPhotoStatisticsUseCase: FetchPhotoStatisticsUseCaseProtocol { get }
    var fetchUserPhotosUseCase: FetchUserPhotosUseCaseProtocol { get }
}

struct TodayDetailsViewModelInput: TodayDetailsViewModelInputable {
    let username: String
    let photoId: String
    let viewEventPublisher: AnyPublisher<TodayDetailsViewEvent, Never>
    let fetchPhotoStatisticsUseCase: FetchPhotoStatisticsUseCaseProtocol
    let fetchUserPhotosUseCase: FetchUserPhotosUseCaseProtocol
}
