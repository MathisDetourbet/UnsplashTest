//
//  PhotoStatisticsDTO.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

struct PhotoStatisticsDTO: Decodable {
    let downloads: PhotoStatisticsDownloadsDTO
    let views: PhotoStatisticsViewsDTO
}
