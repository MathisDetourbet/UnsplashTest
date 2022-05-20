//
//  HTTPError.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

enum HTTPError: LocalizedError {
    case badRequest             // code 400
    case unauthorized           // code 401
    case notFound               // code 404
    case internalServerError    // code 5xx
    case decodingError
    case noResponseData
    case unknown(Error)

    init(error: Error) {
        let nsError = error as NSError
        self = Self.makeFromNSError(nsError)
    }
    
    private static func makeFromErrorStatusCode(_ statusCode: Int) -> HTTPError {
        switch statusCode {
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 404:
            return .notFound
        case 500..<600:
            return .internalServerError
        default:
            return .unknown(NSError(domain: "unknown error", code: statusCode, userInfo: nil))
        }
    }
    
    static func makeFromHTTPURLResponse(_ httpResponse: HTTPURLResponse) -> HTTPError {
        return self.makeFromErrorStatusCode(httpResponse.statusCode)
    }
    
    static func makeFromNSError(_ nsError: NSError) -> HTTPError {
        return self.makeFromErrorStatusCode(nsError.code)
    }

    func toURLError() -> URLError {
        switch self {
        case .badRequest:
            return .init(.badURL)
        case .unauthorized:
            return .init(.userAuthenticationRequired)
        case .notFound:
            return .init(.fileDoesNotExist)
        case .internalServerError:
            return .init(.badServerResponse)
        case .decodingError:
            return .init(.cannotDecodeContentData)
        case .noResponseData:
            return .init(.timedOut)
        case .unknown:
            return .init(.unknown)
        }
    }
}

extension HTTPError: Equatable {
    static func == (lhs: HTTPError, rhs: HTTPError) -> Bool {
        switch (lhs, rhs) {
        case (.badRequest, .badRequest): return true
        case (.decodingError, .decodingError): return true
        case (.unauthorized, .unauthorized): return true
        case (.notFound, .notFound): return true
        case (.internalServerError, .internalServerError): return true
        case (.noResponseData, .noResponseData): return true
        case (.unknown(_), .unknown(_)): return true
        default: return false
        }
    }
}
