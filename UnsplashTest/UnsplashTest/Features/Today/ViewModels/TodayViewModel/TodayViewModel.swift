//
//  TodayViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import Combine

protocol TodayViewModelable: TableOrCollectionViewModel {
    typealias Input = TodayViewModelInputable
    typealias Output = TodayViewModelOutputable

    var output: Output { get }
    init(input: Input)
}

final class TodayViewModel: TodayViewModelable {
    private(set) var viewableList: [PhotoCellViewModelable]
    private let fetchTodayFeedUseCase: FetchTodayFeedUseCaseProtocol

    let output: Output

    init(input: Input) {
        self.fetchTodayFeedUseCase = input.fetchTodayFeedUseCase
        self.viewableList = []

        let reloadPhotosPublisher = input.viewEventPublisher
            .map { viewEvent -> Void in
                switch viewEvent {
                case .viewDidLoad:
                    return ()
                }
            }
            .eraseToAnyPublisher()

        self.output = TodayViewModelOutput(
            reloadPhotosPublisher: reloadPhotosPublisher,
            headerViewModel: TodayCollectionViewHeaderSectionSupplementaryViewModel()
        )
    }
}
