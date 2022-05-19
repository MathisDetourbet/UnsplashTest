//
//  PhotoCellViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit
import Combine

protocol PhotoCellViewModelable {
    var backgroundImage: AnyPublisher<UIImage?, Never> { get }
    var description: String? { get }
    var userImage: AnyPublisher<UIImage?, Never> { get }
    var username: String { get }
    var likesCountString: String { get }
}
