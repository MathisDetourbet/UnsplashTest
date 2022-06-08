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
    private let photoViewModel: PhotoViewModel
    private weak var coordinatorDelegate: TodayDetailsCoordinatorDelegate?

    init(
        todayDetailsDependencies: TodayDetailsDependencies,
        coordinatorDelegate: TodayDetailsCoordinatorDelegate
    ) {
        self.photoViewModel = todayDetailsDependencies.photoViewModel
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
            photoViewModel: self.photoViewModel,
            viewEventPublisher: viewEventPublisher,
            fetchPhotoStatisticsUseCase: fetchPhotoStatisticsUseCase,
            fetchUserPhotosUseCase: fetchUserPhotosUseCase,
            coordinatorDelegate: self.coordinatorDelegate
        )
        return .init(input: input)
    }
}
