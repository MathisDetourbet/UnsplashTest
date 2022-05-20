//
//  TodayViewModelInput.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine

protocol TodayViewModelInputable {
    var fetchTodayFeedUseCase: FetchTodayFeedUseCaseProtocol { get }
    var viewEventInputPublisher: AnyPublisher<TodayViewEvent, Never> { get }
}

struct TodayViewModelInput: TodayViewModelInputable {
    let fetchTodayFeedUseCase: FetchTodayFeedUseCaseProtocol
    let viewEventInputPublisher: AnyPublisher<TodayViewEvent, Never>
}
