//
//  TodayViewEvent.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

enum TodayViewEvent {
    /// The view is setup
    case viewDidLoad
    /// The user did select a photo.
    case didSelectPhoto(indexPath: IndexPath, transitionModel: TodayCustomTransitionModel?)
}

extension TodayViewEvent: Equatable {}
