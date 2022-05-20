//
//  PhotoViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit
import Combine

struct PhotoViewModel: PhotoCellViewModelable {
    let backgroundImageURL: URL?
    let userImageURL: URL?
    let description: String?
    let username: String
    let likesCountString: String

    init(entity: PhotoEntity) {
        self.backgroundImageURL = entity.imageURL
        self.userImageURL = entity.userEntity.profileImageEntity.smallURL
        self.description = entity.description
        self.username = entity.userEntity.username
        self.likesCountString = "\(entity.likesCount) likes"
    }
}
