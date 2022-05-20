//
//  NetworkService.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation
import Combine

protocol NetworkService {
    func send<T: Decodable>(_ request: NetworkRequest, decodedType: T.Type) -> AnyPublisher<T, HTTPError>
}
