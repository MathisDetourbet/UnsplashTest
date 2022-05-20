//
//  TodayDetailsViewModelInput.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Combine

protocol TodayDetailsViewModelInputable {
    var userId: String { get }
    var photoId: String { get }
    var viewEventPublisher: AnyPublisher<TodayDetailsViewEvent, Never> { get }
}

struct TodayDetailsViewModelInput: TodayDetailsViewModelInputable {
    let userId: String
    let photoId: String
    let viewEventPublisher: AnyPublisher<TodayDetailsViewEvent, Never>
}
