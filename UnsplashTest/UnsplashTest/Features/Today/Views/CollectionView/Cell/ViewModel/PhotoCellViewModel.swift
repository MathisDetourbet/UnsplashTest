//
//  PhotoCellViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit

protocol PhotoCellViewModelable {
    var backgroundImageURL: URL? { get }
    var description: String? { get }
    var userImageURL: URL? { get }
    var username: String { get }
    var likesCountString: String { get }
}
