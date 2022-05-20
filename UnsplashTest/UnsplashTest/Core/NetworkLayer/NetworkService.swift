//
//  NetworkService.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation
import Combine

protocol NetworkService {
    func sendRequest<T: Decodable>(_ request: NetworkRequest) -> AnyPublisher<T, HTTPError>
}
