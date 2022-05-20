//
//  TodayDetailsFactory.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine

protocol TodayDetailsFactoryProtocol {
    func createViewModel(
        viewEventPublisher: AnyPublisher<TodayDetailsViewEvent, Never>
    ) -> TodayDetailsViewModel
}

final class TodayDetailsFactory: TodayDetailsFactoryProtocol {
    private let todayDetailsDependencies: TodayDetailsDependencies
    private let username: String
    private let photoId: String
    private weak var coordinatorDelegate: TodayDetailsCoordinatorDelegate?

    init(
        todayDetailsDependencies: TodayDetailsDependencies,
        coordinatorDelegate: TodayDetailsCoordinatorDelegate
    ) {
        self.username = todayDetailsDependencies.username
        self.photoId = todayDetailsDependencies.photoId
        self.todayDetailsDependencies = todayDetailsDependencies
        self.coordinatorDelegate = coordinatorDelegate
    }

    func createViewModel(
        viewEventPublisher: AnyPublisher<TodayDetailsViewEvent, Never>
    ) -> TodayDetailsViewModel {
        let fetchPhotoStatisticsUseCase = FetchPhotoStatisticsUseCase(
            photoStatisticsRepository: self.todayDetailsDependencies.photoStatisticsRepository
        )
        let fetchUserPhotosUseCase = FetchUserPhotosUseCase(
            repository: self.todayDetailsDependencies.userPhotosRepository
        )
        let input = TodayDetailsViewModelInput(
            username: self.username,
            photoId: self.photoId,
            viewEventPublisher: viewEventPublisher,
            fetchPhotoStatisticsUseCase: fetchPhotoStatisticsUseCase,
            fetchUserPhotosUseCase: fetchUserPhotosUseCase,
            coordinatorDelegate: self.coordinatorDelegate
        )
        return .init(input: input)
    }
}
