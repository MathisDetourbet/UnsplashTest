//
//  TodayUserSelection.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation

struct TodayUserSelection {
    let photoViewModel: PhotoViewModel
    let transitionModel: TodayCustomTransitionModel?

    init?(
        viewEvent: TodayViewEvent,
        photosViewModel: [PhotoViewModel]
    ) {
        guard !photosViewModel.isEmpty else {
            return nil
        }
        
        switch viewEvent {
        case .didSelectPhoto(let indexPath, let transitionModel):
            guard indexPath.item < photosViewModel.count else {
                return nil
            }
            self.photoViewModel = photosViewModel[indexPath.item]
            self.transitionModel = transitionModel
        default:
            return nil
        }
    }
}
