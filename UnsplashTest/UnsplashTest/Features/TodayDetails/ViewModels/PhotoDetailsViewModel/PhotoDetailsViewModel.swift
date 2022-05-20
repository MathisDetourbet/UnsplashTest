//
//  PhotoDetailsViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

protocol PhotoDetailsViewModelable {
    var imageURL: URL? { get }
}

struct PhotoDetailsViewModel: PhotoDetailsViewModelable {
    let imageURL: URL?

    init(photoEntity: PhotoEntity) {
        self.imageURL = photoEntity.imageURL
    }
}
