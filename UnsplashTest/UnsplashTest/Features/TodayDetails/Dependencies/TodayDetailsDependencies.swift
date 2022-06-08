//
//  TodayDetailsDependencies.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

struct TodayDetailsDependencies {
    let photoViewModel: PhotoViewModel
    let photoStatisticsRepository: PhotoStatisticsRepositoryProtocol
    let userPhotosRepository: UserPhotosRepositoryProtocol
}
