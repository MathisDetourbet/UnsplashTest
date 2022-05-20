//
//  PhotoDTO.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

struct PhotoDTO: Decodable {
    let id: String
    let description: String?
    let likes: Int
    let user: UserDTO
    let urls: URLs
}
