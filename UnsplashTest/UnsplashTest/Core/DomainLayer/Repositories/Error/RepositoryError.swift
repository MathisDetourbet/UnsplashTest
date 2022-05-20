//
//  RepositoryError.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

enum RepositoryError: LocalizedError, Equatable, CaseIterable {
    /// User is disconnected.
    case notAuthenticated
    /// Server error `500`.
    case internalServer
    /// Model decoding error.
    case decodingError
    /// Request is wrong.
    case badRequest
    /// Not found `404`.
    case notFound
    /// Error of type network. It could be "no network" or "network unknown".
    case network
    /// Response data lenght equals to zero.
    case empty
    /// Unknown error.
    case unknown

    init(httpError: HTTPError) {
        switch httpError {
        case .badRequest:
            self = .badRequest
        case .unauthorized:
            self = .notAuthenticated
        case .notFound:
            self = .notFound
        case .internalServerError:
            self = .internalServer
        case .decodingError:
            self = .decodingError
        case .noResponseData:
            self = .empty
        case .unknown:
            self = .unknown
        }
    }
}
