//
//  FetchTodayFeedUseCase.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation
import Combine

/// Fetch ten photos to feed the TODAY screen use case.
protocol FetchTodayFeedUseCaseProtocol {
    func execute() -> AnyPublisher<[PhotoEntity], FetchTodayFeedUseCase.FetchError>
}

final class FetchTodayFeedUseCase: FetchTodayFeedUseCaseProtocol {

    let repository: PhotosRepositoryProtocol

    init(photosRepository: PhotosRepositoryProtocol) {
        self.repository = photosRepository
    }

    func execute() -> AnyPublisher<[PhotoEntity], FetchError> {
        return self.repository
            .getPhotos()
            .mapError(FetchError.init)
            .eraseToAnyPublisher()
    }
}

extension FetchTodayFeedUseCase {

    // Business error
    enum FetchError: Error {
        // Generic means the business don't want to specialize errors for now.
        // If we want to display specific error, we just need to add new cases.
        case generic

        init(_: RepositoryError) {
            self = .generic
        }
    }
}
