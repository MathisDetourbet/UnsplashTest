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
    private(set) var viewableList: [PhotoDetailsViewModel]
    private var subscriptions: Set<AnyCancellable> = []

    let output: Output

    init(input: Input) {
        self.viewableList = []

        let username = input.photoViewModel.username
        let photoId = input.photoViewModel.photoId

        let fetchesPublisher = input.viewEventPublisher
            .filter { $0 == .viewDidLoad }
            .setFailureType(to: ViewModelError.self)
            .flatMap { _ in
                Publishers.Zip(
                    input.fetchUserPhotosUseCase
                        .execute(forUsername: username)
                        .mapError(ViewModelError.init)
                        .eraseToAnyPublisher(),
                    input.fetchPhotoStatisticsUseCase
                        .execute(forPhotoId: photoId)
                        .mapError(ViewModelError.init)
                        .eraseToAnyPublisher()
                )
            }
            .share()
            .eraseToAnyPublisher()

        let reloadPhotosPublisher = fetchesPublisher
            .map { _ in () }
            .catch { _ in
                Just(()).eraseToAnyPublisher()
            }
            .share()
            .eraseToAnyPublisher()

        let footerViewModelPublisher = fetchesPublisher
            .map(\.1) // PhotoStatistics
            .map { photoStatistics in
                return TodayDetailsCollectionViewFooterSectionSupplementaryViewModel(
                    viewsCountPublisher: Just(photoStatistics.totalViews).eraseToAnyPublisher(),
                    downloadsCountPublisher: Just(photoStatistics.totalDownloads).eraseToAnyPublisher()
                ) as TodayDetailsCollectionViewFooterSectionSupplementaryViewModelable
            }
            .mapError { _ in ViewModelError.generic }
            .eraseToAnyPublisher()

        self.output = TodayDetailsViewModelOutput(
            reloadPhotosPublisher: reloadPhotosPublisher,
            footerViewModelPublisher: footerViewModelPublisher
        )

        let userPhotosPublisher = fetchesPublisher
            .map(\.0)
            .catch { _ in
                Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()

        Publishers
            .CombineLatest(
                Just(input.photoViewModel)
                    .map(PhotoDetailsViewModel.init)
                    .eraseToAnyPublisher(),
                Publishers.Merge(
                    userPhotosPublisher,
                    Just([]).eraseToAnyPublisher()
                )
                .eraseToAnyPublisher()
            )
            .map { selectedPhotoViewModel, userPhotosEntity -> [PhotoDetailsViewModel] in
                return [selectedPhotoViewModel] + userPhotosEntity.map(PhotoDetailsViewModel.init)
            }
            .sink { [weak self] photoDetailsViewModel in
                self?.viewableList = photoDetailsViewModel
            }
            .store(in: &self.subscriptions)

        input.viewEventPublisher
            .filter { $0 == .didTapOnClose }
            .sink { [input] _ in
                input.coordinatorDelegate?.userDidTapOnClose()
            }
            .store(in: &self.subscriptions)
    }
}

extension TodayDetailsViewModel {

    enum ViewModelError: Error {
        case generic

        init(fetchUserPhotosUseCaseError: FetchUserPhotosUseCase.FetchError) {
            self = .generic
        }

        init(fetchPhotoStatisticsUseCaseError: FetchPhotoStatisticsUseCase.FetchError) {
            self = .generic
        }
    }
}
