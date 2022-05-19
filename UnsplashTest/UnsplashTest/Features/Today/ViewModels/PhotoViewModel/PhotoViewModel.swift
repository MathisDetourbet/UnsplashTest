//
//  PhotoViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit
import Combine

struct PhotoViewModel: PhotoCellViewModelable {
    let backgroundImage: AnyPublisher<UIImage?, Never>
    let description: String?
    let userImage: AnyPublisher<UIImage?, Never>
    let username: String
    let likesCountString: String
}
