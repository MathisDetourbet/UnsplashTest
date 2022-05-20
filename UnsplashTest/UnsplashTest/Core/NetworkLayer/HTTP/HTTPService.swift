//
//  HTTPService.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation
import Combine

final class HTTPService: NetworkService {
    private static let successCodeRange = 200..<300
    private let session = URLSession(configuration: .default)

    func sendRequest<T: Decodable>(_ httpRequest: NetworkRequest) -> AnyPublisher<T, HTTPError> {
        guard let httpRequest = httpRequest as? HTTPRequest else {
            return Fail(
                outputType: T.self,
                failure: HTTPError.badRequest
            )
            .eraseToAnyPublisher()
        }

        return Just(httpRequest)
            .setFailureType(to: HTTPError.self)
            .flatMap { [weak self] httpRequest in
                self?.buildURLRequest(from: httpRequest) ?? Fail(outputType: URLRequest.self, failure: HTTPError.badRequest).eraseToAnyPublisher()
            }
            .mapError { $0.toURLError() }
            .flatMap { [weak self] urlRequest -> URLSession.DataTaskPublisher in
                guard let session = self?.session else {
                    return URLSession.DataTaskPublisher(request: urlRequest, session: URLSession.shared)
                }
                return session.dataTaskPublisher(for: urlRequest)
            }
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .handleEvents(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            })
            .mapError(HTTPError.init)
            .share()
            .eraseToAnyPublisher()
    }

    private func buildURLRequest(
        from httpRequest: HTTPRequest
    ) -> AnyPublisher<URLRequest, HTTPError> {
        var urlRequest: URLRequest
        do {
            urlRequest = try URLRequest.makeFromHTTPRequest(httpRequest)
            self.injectAuthorizationHeaders(in: &urlRequest)
        } catch let nsError as NSError {
            return Fail(
                outputType: URLRequest.self,
                failure: HTTPError.makeFromNSError(nsError)
            )
            .eraseToAnyPublisher()
        }
        return Just(urlRequest).setFailureType(to: HTTPError.self).eraseToAnyPublisher()
    }
}

// MARK: - Authorization header
private extension HTTPService {

    private static let apiAccessPlistKey = "apiAccessKey"
    private static let authorizationHeaderField = "Authorization"

    private func injectAuthorizationHeaders(in urlRequest: inout URLRequest) {
        urlRequest.addValue(apiAccessKey, forHTTPHeaderField: Self.authorizationHeaderField)
    }

    private var apiAccessKey: String {
        guard let filePath = Bundle.main.path(forResource: "UnsplashAPIConfiguration", ofType: "plist") else {
            fatalError("Didn't find api access key plist file")
        }

        let plist = NSDictionary(contentsOfFile: filePath)
        guard let apiKey = plist?.object(forKey: Self.apiAccessPlistKey) as? String else {
            fatalError("Couldn't find key \(Self.apiAccessPlistKey) in plist")
        }
        return apiKey
    }
}
