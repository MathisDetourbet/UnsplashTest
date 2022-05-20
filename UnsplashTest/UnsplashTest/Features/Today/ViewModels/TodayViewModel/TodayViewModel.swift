//
//  TodayViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import Combine

final class TodayViewModel: TableOrCollectionViewModel {
    private(set) var viewableList: [PhotoCellViewModelable]
    let headerViewModel = TodayCollectionViewHeaderSectionSupplementaryViewModel()

    init() {
        self.viewableList = []
    }
}
