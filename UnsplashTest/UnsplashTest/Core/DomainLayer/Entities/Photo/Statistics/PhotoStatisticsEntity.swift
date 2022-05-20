//
//  PhotoStatisticsEntity.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

struct PhotoStatisticsEntity {
    let totalDownloads: Int
    let totalViews: Int
}

extension PhotoStatisticsEntity: EntityInitializable {

    init(from dto: PhotoStatisticsDTO) {
        self.totalDownloads = dto.downloadsDTO.total
        self.totalViews = dto.viewsDTO.total
    }
}
