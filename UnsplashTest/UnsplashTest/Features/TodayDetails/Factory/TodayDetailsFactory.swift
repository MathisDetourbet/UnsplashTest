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
    let userId: String
    let photoId: String

    init(
        userId: String,
        photoId: String
    ) {
        self.userId = userId
        self.photoId = photoId
    }

    func createViewModel(
        viewEventPublisher: AnyPublisher<TodayDetailsViewEvent, Never>
    ) -> TodayDetailsViewModel {
        let input = TodayDetailsViewModelInput(
            userId: self.userId,
            photoId: self.photoId,
            viewEventPublisher: viewEventPublisher
        )
        return .init(input: input)
    }
}
