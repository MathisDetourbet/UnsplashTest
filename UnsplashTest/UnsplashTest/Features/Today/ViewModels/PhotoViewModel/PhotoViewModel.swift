//
//  PhotoViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit
import Combine

struct PhotoViewModel: PhotoCellViewModelable {
    let backgroundImageURL: URL
    let userImageURL: URL
    let description: String?
    let username: String
    let likesCountString: String
}
