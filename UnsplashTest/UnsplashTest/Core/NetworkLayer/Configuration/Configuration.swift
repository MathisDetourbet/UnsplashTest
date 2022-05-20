//
//  Configuration.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

protocol Configuration {
    var netProtocol: String { get }
    var domain: String { get }
}

extension Configuration {
    var urlScheme: URL? { .init(string: "\(netProtocol)\(domain)") }
}
