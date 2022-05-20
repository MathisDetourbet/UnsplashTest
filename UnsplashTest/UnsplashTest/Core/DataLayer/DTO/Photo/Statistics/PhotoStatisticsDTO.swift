//
//  PhotoStatisticsDTO.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

struct PhotoStatisticsDTO: Decodable {
    let downloadsDTO: PhotoStatisticsDownloadsDTO
    let viewsDTO: PhotoStatisticsViewsDTO

    enum CodingKeys: String, CodingKey {
        case downloadsDTO = "downloads"
        case viewsDTO = "views"
    }
}
