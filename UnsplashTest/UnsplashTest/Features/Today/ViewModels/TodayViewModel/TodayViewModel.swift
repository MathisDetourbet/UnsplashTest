//
//  TodayViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import Combine

final class TodayViewModel: TableOrCollectionViewModel {
    private(set) var viewableList: [PhotoCellViewModelable]
    private let fetchTodayFeedUseCase: FetchTodayFeedUseCaseProtocol

    let headerViewModel = TodayCollectionViewHeaderSectionSupplementaryViewModel()

    init(fetchTodayFeedUseCase: FetchTodayFeedUseCaseProtocol) {
        self.fetchTodayFeedUseCase = fetchTodayFeedUseCase
        self.viewableList = []
    }
}
