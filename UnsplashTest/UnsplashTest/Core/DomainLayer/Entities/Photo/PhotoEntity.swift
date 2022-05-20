//
//  PhotoEntity.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

struct PhotoEntity {
    let id: String
    let description: String?
    let imageURL: URL?
    let userEntity: UserEntity
    let likesCount: Int
}

extension PhotoEntity: EntityInitializable {

    init(from dto: PhotoDTO) {
        self.id = dto.id
        self.description = dto.description
        self.imageURL = URL(string: dto.urlsDTO.regular)
        self.userEntity = UserEntity(from: dto.userDTO)
        self.likesCount = dto.likes
    }
}
