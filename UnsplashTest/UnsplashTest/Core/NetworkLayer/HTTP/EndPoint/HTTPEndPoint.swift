//
//  HTTPEndPoint.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

enum HTTPEndPoint: CustomStringConvertible {
    case feedPhotos
    case userPhotos(username: String)
    case photoStatistics(id: String)
    
    var description: String {
        switch self {
        case .feedPhotos:
            return "/photos"
        case .userPhotos(let username):
            return "/users/\(username)/photos"
        case .photoStatistics(let id):
            return "/photos/\(id)/statistics"
        }
    }
}
