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
    private let userId: String
    private let photoId: String

    init(
        userId: String,
        photoId: String,
        todayDetailsDependencies: TodayDetailsDependencies
    ) {
        self.userId = userId
        self.photoId = photoId
        self.todayDetailsDependencies = todayDetailsDependencies
    }

    func createViewModel(
        viewEventPublisher: AnyPublisher<TodayDetailsViewEvent, Never>
    ) -> TodayDetailsViewModel {
        let fetchPhotoStatisticsUseCase = FetchPhotoStatisticsUseCase(
            photoStatisticsRepository: self.todayDetailsDependencies.photoStatisticsRepository
        )
        let input = TodayDetailsViewModelInput(
            userId: self.userId,
            photoId: self.photoId,
            viewEventPublisher: viewEventPublisher,
            fetchPhotoStatisticsUseCase: fetchPhotoStatisticsUseCase
        )
        return .init(input: input)
    }
}
