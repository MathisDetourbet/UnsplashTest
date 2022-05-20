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
    let userDTO: UserDTO
    let urlsDTO: URLsDTO

    enum CodingKeys: String, CodingKey {
        case id
        case description
        case likes
        case userDTO = "user"
        case urlsDTO = "urls"
    }
}
