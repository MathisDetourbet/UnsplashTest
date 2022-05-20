//
//  PhotosRepository.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine

protocol PhotosRepositoryProtocol {
    func getPhotos() -> AnyPublisher<[PhotoEntity], RepositoryError>
}

final class PhotosRepository: PhotosRepositoryProtocol {
    let httpService: NetworkService
    let httpConfiguration: HTTPConfiguration

    init(
        httpService: NetworkService,
        httpConfiguration: HTTPConfiguration
    ) {
        self.httpService = httpService
        self.httpConfiguration = httpConfiguration
    }

    func getPhotos() -> AnyPublisher<[PhotoEntity], RepositoryError> {
        let request = HTTPRequest(
            baseUrl: self.httpConfiguration.urlScheme,
            endPoint: .feedPhotos,
            method: .get,
            headers: nil,
            parameters: nil,
            isPublic: true
        )
        return Deferred {
            return self.httpService
                .send(request, decodedType: [PhotoDTO].self)
                .map { photoDTO in
                    return photoDTO.map(PhotoEntity.init)
                }
                .mapError(RepositoryError.init)
                .first()
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
