//
//  PictureViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

protocol PictureViewModelable {
    var imageURL: URL? { get }
}

struct PictureViewModel: PictureViewModelable {
    let imageURL: URL?
}
