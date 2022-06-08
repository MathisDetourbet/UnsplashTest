//
//  FetchUserPhotosUseCase.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine

protocol FetchUserPhotosUseCaseProtocol {
    func execute(forUsername username: String) -> AnyPublisher<[PhotoEntity], FetchUserPhotosUseCase.FetchError>
}

final class FetchUserPhotosUseCase: FetchUserPhotosUseCaseProtocol {

    let repository: UserPhotosRepositoryProtocol

    init(repository: UserPhotosRepositoryProtocol) {
        self.repository = repository
    }

    func execute(forUsername username: String) -> AnyPublisher<[PhotoEntity], FetchError> {
        return self.repository
            .getUserPhotos(forUsername: username)
            .mapError(FetchError.init)
            .eraseToAnyPublisher()
    }
}

extension FetchUserPhotosUseCase {

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
