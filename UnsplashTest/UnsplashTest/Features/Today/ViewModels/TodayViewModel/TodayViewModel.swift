//
//  TodayViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import Combine
import CoreImage

protocol TodayViewModelable: TableOrCollectionViewModel {
    typealias Input = TodayViewModelInputable
    typealias Output = TodayViewModelOutputable

    var output: Output { get }
    init(input: Input)
}

final class TodayViewModel: TodayViewModelable {
    private var photosViewModel: [PhotoViewModel]
    var viewableList: [PhotoCellViewModelable] { self.photosViewModel }
    private let fetchTodayFeedUseCase: FetchTodayFeedUseCaseProtocol
    private var subscriptions: Set<AnyCancellable> = []

    let output: Output

    init(input: Input) {
        self.fetchTodayFeedUseCase = input.fetchTodayFeedUseCase
        self.photosViewModel = []

        let photosViewModelPublisher = input.viewEventPublisher
            .filter { $0 == .viewDidLoad }
            .setFailureType(to: FetchTodayFeedUseCase.FetchError.self)
            .flatMap { _ -> AnyPublisher<[PhotoEntity], FetchTodayFeedUseCase.FetchError> in
                return input.fetchTodayFeedUseCase.execute()
            }
            .map { photosEntity in
                return photosEntity.map(PhotoViewModel.init)
            }
            .share()

        let reloadPhotosPublisher = photosViewModelPublisher
            .map { _ in () }
            .catch { _ in
                Just(()).eraseToAnyPublisher()
            }
            .share()
            .eraseToAnyPublisher()

        self.output = TodayViewModelOutput(
            reloadPhotosPublisher: reloadPhotosPublisher,
            headerViewModel: TodayCollectionViewHeaderSectionSupplementaryViewModel()
        )

        photosViewModelPublisher
            .sink(receiveCompletion: { _ in }) { [weak self] photosViewModel in
                self?.photosViewModel = photosViewModel
            }
            .store(in: &self.subscriptions)

        input.viewEventPublisher
            .map { [weak self] viewEvent -> TodayUserSelection? in
                guard let self = self else {
                    return nil
                }
                switch viewEvent {
                case .didSelectPhoto(let indexPath):
                    return Self.userSelection(at: indexPath, in: self.photosViewModel)
                default:
                    return nil
                }
            }
            .sink { [input] userSelection in
                guard let userSelection = userSelection else {
                    return
                }
                input.coordinatorDelegate?.userDidSelectPhoto(
                    withId: userSelection.photoId,
                    forUser: userSelection.userId
                )
            }
            .store(in: &self.subscriptions)
    }

    private static func userSelection(
        at indexPath: IndexPath,
        in photosViewModel: [PhotoViewModel]
    ) -> TodayUserSelection? {
        let selectedPhoto = photosViewModel[indexPath.item]
        let photoId = selectedPhoto.photoId
        let userId = selectedPhoto.userId
        return (userId, photoId)
    }
}

