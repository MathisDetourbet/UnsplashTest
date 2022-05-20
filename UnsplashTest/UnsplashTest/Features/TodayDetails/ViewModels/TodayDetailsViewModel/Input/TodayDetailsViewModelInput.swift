//
//  TodayDetailsViewModelInput.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

protocol TodayDetailsViewModelInputable {
    var userId: String { get }
    var photoId: String { get }
}

struct TodayDetailsViewModelInput: TodayDetailsViewModelInputable {
    let userId: String
    let photoId: String
}
