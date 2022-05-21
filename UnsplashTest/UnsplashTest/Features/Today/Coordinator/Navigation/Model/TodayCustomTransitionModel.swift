//
//  TodayCustomTransitionModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 21/05/2022.
//

import UIKit

struct TodayCustomTransitionModel: Equatable {
    let originFrame: CGRect
    let originView: UIView
    let photoImage: UIImage
    let finalFrame: CGRect

    init(
        originFrame: CGRect,
        originView: UIView,
        photoImage: UIImage,
        finalFrame: CGRect
    ) {
        self.originFrame = originFrame
        self.originView = originView
        self.photoImage = photoImage
        self.finalFrame = finalFrame
    }
}
