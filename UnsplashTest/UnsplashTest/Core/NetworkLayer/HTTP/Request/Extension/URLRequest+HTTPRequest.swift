//
//  URLRequest+HTTPRequest.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 14/10/20.
//

import Foundation

extension URLRequest {
    static func makeFromHTTPRequest(_ httpRequest: HTTPRequest) throws -> Self {
        guard let url = httpRequest.fullUrl else {
            throw HTTPError.badRequest
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpRequest.method.rawValue
        urlRequest.allHTTPHeaderFields = httpRequest.headers
        return urlRequest
    }
}
