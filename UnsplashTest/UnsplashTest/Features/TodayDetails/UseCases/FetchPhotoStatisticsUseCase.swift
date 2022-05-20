//
//  FetchPhotoStatisticsUseCase.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine

protocol FetchPhotoStatisticsUseCaseProtocol {
    func execute(forPhotoId id: String) -> AnyPublisher<PhotoStatisticsEntity, FetchPhotoStatisticsUseCase.FetchError>
}

final class FetchPhotoStatisticsUseCase: FetchPhotoStatisticsUseCaseProtocol {

    let repository: PhotoStatisticsRepositoryProtocol

    init(photoStatisticsRepository: PhotoStatisticsRepositoryProtocol) {
        self.repository = photoStatisticsRepository
    }

    func execute(forPhotoId id: String) -> AnyPublisher<PhotoStatisticsEntity, FetchError> {
        return self.repository
            .getPhotoStatistics(forPhotoId: id)
            .mapError(FetchError.init)
            .eraseToAnyPublisher()
    }
}

extension FetchPhotoStatisticsUseCase {

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
