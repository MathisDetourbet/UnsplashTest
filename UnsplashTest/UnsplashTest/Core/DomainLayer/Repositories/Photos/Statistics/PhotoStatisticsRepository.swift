//
//  PhotoStatisticsRepository.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine

protocol PhotoStatisticsRepositoryProtocol {
    func getPhotoStatistics(forPhotoId id: String) -> AnyPublisher<PhotoStatisticsEntity, RepositoryError>
}

final class PhotoStatisticsRepository: PhotoStatisticsRepositoryProtocol {

    let httpService: NetworkService
    let httpConfiguration: HTTPConfiguration

    init(
        httpService: NetworkService,
        httpConfiguration: HTTPConfiguration
    ) {
        self.httpService = httpService
        self.httpConfiguration = httpConfiguration
    }

    func getPhotoStatistics(forPhotoId id: String) -> AnyPublisher<PhotoStatisticsEntity, RepositoryError> {
        let request = HTTPRequest(
            baseUrl: self.httpConfiguration.urlScheme,
            endPoint: .photoStatistics(id: id),
            method: .get,
            headers: nil,
            parameters: nil,
            isPublic: true
        )
        
        return Deferred {
            return self.httpService
                .send(request, decodedType: PhotoStatisticsDTO.self)
                .map(PhotoStatisticsEntity.init)
                .mapError(RepositoryError.init)
                .first()
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
