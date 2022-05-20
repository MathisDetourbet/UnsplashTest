//
//  HTTPRequest.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

protocol NetworkRequest {
    var baseUrl: URL { get }
}

struct HTTPRequest: NetworkRequest {
    let baseUrl: URL
    let endPoint: HTTPEndPoint
    let method: HTTPMethod
    let headers: HTTPHeaders?
    let parameters: Encodable?
    let isPublic: Bool
    
    var fullUrl: URL? {
        return URL(string: self.baseUrl.absoluteString + self.endPoint.description)
    }
}
