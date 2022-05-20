//
//  UserEntity.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

struct UserEntity {
    let id: String
    let username: String
    let profileImageEntity: ProfileImageEntity
}

// MARK: - ProfileImageEntity definition
extension UserEntity {

    struct ProfileImageEntity: EntityInitializable {
        let smallURL: URL?

        init(from dto: ProfileImageDTO) {
            self.smallURL = URL(string: dto.small)
        }
    }
}

// MARK: - EntityInitializable implementation
extension UserEntity: EntityInitializable {

    init(from dto: UserDTO) {
        self.id = dto.id
        self.username = dto.username
        self.profileImageEntity = ProfileImageEntity(from: dto.profileImageDTO)
    }
}
