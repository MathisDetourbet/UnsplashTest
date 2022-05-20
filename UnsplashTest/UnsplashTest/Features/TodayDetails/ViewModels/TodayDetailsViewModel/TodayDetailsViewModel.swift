//
//  TodayDetailsViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine
import CoreText

protocol TodayDetailsViewModelable: TableOrCollectionViewModel {
    typealias Input = TodayDetailsViewModelInputable
    typealias Output = TodayDetailsViewModelOutputable

    var output: Output { get }
    init(input: Input)
}

final class TodayDetailsViewModel: TodayDetailsViewModelable {
    private(set) var viewableList: [PictureViewModelable]

    let output: Output

    init(input: Input) {
        self.viewableList = []

        let footerViewModel = TodayDetailsCollectionViewFooterSectionSupplementaryViewModel(
            viewsCountPublisher: Empty().eraseToAnyPublisher(),
            downloadsCountPublisher: Empty().eraseToAnyPublisher()
        )

        self.output = TodayDetailsViewModelOutput(
            reloadPhotosPublisher: Empty().eraseToAnyPublisher(),
            footerViewModel: footerViewModel
        )
    }
}
