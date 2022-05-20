//
//  TodayViewModelInput.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine

protocol TodayViewModelInputable {
    var fetchTodayFeedUseCase: FetchTodayFeedUseCaseProtocol { get }
    var viewEventPublisher: AnyPublisher<TodayViewEvent, Never> { get }
    var coordinatorDelegate: TodayNavigationCoordinatorDelegate? { get set }
}

struct TodayViewModelInput: TodayViewModelInputable {
    let fetchTodayFeedUseCase: FetchTodayFeedUseCaseProtocol
    let viewEventPublisher: AnyPublisher<TodayViewEvent, Never>
    weak var coordinatorDelegate: TodayNavigationCoordinatorDelegate?
}
