//
//  TodayFactory.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine

protocol TodayFactoryProtocol {
    func createViewModel(
        viewEventInputPublisher: AnyPublisher<TodayViewEvent, Never>
    ) -> TodayViewModel
}

final class TodayFactory: TodayFactoryProtocol {
    private let todayDependencies: TodayDependencies

    init(todayDependencies: TodayDependencies) {
        self.todayDependencies = todayDependencies
    }

    func createViewModel(
        viewEventInputPublisher: AnyPublisher<TodayViewEvent, Never>
    ) -> TodayViewModel {
        let fetchTodayUseCase = FetchTodayFeedUseCase(
            photosRepository: self.todayDependencies.photosRepository
        )
        let input = TodayViewModelInput(
            fetchTodayFeedUseCase: fetchTodayUseCase,
            viewEventInputPublisher: viewEventInputPublisher
        )
        return TodayViewModel(input: input)
    }
}
