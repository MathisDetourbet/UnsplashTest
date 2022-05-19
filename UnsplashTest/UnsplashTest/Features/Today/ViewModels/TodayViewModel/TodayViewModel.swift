//
//  TodayViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import Foundation

final class TodayViewModel: TableOrCollectionViewModel {
    private(set) var viewableList: [PhotoViewModel]
    let headerViewModel = TodayCollectionViewHeaderSectionSupplementaryViewModel()

    init() {
        self.viewableList = []
    }
}
