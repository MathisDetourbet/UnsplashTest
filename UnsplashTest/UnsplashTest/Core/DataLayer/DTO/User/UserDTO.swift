//
//  UserDTO.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

struct UserDTO: Decodable {
    let id: String
    let username: String
    let profileImageDTO: ProfileImageDTO
}
