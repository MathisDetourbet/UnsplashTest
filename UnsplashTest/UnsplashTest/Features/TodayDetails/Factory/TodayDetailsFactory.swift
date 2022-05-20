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

    init(
        todayDetailsDependencies: TodayDetailsDependencies
    ) {
        self.username = todayDetailsDependencies.username
        self.photoId = todayDetailsDependencies.photoId
        self.todayDetailsDependencies = todayDetailsDependencies
    }

    func createViewModel(
        viewEventPublisher: AnyPublisher<TodayDetailsViewEvent, Never>
    ) -> TodayDetailsViewModel {
        let fetchPhotoStatisticsUseCase = FetchPhotoStatisticsUseCase(
            photoStatisticsRepository: self.todayDetailsDependencies.photoStatisticsRepository
        )
        let input = TodayDetailsViewModelInput(
            username: self.username,
            photoId: self.photoId,
            viewEventPublisher: viewEventPublisher,
            fetchPhotoStatisticsUseCase: fetchPhotoStatisticsUseCase
        )
        return .init(input: input)
    }
}
