//
//  TodayFactory.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine

protocol TodayFactoryProtocol {
    func createViewModel(
        viewEventPublisher: AnyPublisher<TodayViewEvent, Never>
    ) -> TodayViewModel
}

final class TodayFactory: TodayFactoryProtocol {
    private let todayDependencies: TodayDependencies
    private weak var coordinatorDelegate: TodayNavigationCoordinatorDelegate?

    init(
        todayDependencies: TodayDependencies,
        coordinatorDelegate: TodayNavigationCoordinatorDelegate
    ) {
        self.todayDependencies = todayDependencies
        self.coordinatorDelegate = coordinatorDelegate
    }

    func createViewModel(
        viewEventPublisher: AnyPublisher<TodayViewEvent, Never>
    ) -> TodayViewModel {
        let fetchTodayUseCase = FetchTodayFeedUseCase(
            photosRepository: self.todayDependencies.photosRepository
        )
        let input = TodayViewModelInput(
            fetchTodayFeedUseCase: fetchTodayUseCase,
            viewEventPublisher: viewEventPublisher,
            coordinatorDelegate: self.coordinatorDelegate
        )
        return TodayViewModel(input: input)
    }
}
