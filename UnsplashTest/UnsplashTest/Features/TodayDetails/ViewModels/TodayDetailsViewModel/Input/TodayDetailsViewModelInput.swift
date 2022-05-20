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
    var coordinatorDelegate: TodayDetailsCoordinatorDelegate? { get set }
}

struct TodayDetailsViewModelInput: TodayDetailsViewModelInputable {
    let username: String
    let photoId: String
    let viewEventPublisher: AnyPublisher<TodayDetailsViewEvent, Never>
    let fetchPhotoStatisticsUseCase: FetchPhotoStatisticsUseCaseProtocol
    let fetchUserPhotosUseCase: FetchUserPhotosUseCaseProtocol
    weak var coordinatorDelegate: TodayDetailsCoordinatorDelegate?
}
