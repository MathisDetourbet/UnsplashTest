//
//  EntityInitializable.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

protocol EntityInitializable {
    associatedtype DTO
    init(from dto: DTO)
}
