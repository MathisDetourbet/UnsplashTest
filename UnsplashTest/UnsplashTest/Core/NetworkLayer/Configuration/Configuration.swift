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

    var urlScheme: URL {
        guard let urlScheme = URL(string: "\(self.netProtocol)\(self.domain)") else {
            fatalError("URL scheme is nil. This should not happen.")
        }
        return urlScheme
    }
}
