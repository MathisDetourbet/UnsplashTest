//
//  TodayCustomPhotoTransitionNavigationController.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 21/05/2022.
//

import UIKit

final class TodayCustomPhotoTransitionNavigationController: NSObject, UINavigationControllerDelegate {
    let transitionModel: TodayCustomTransitionModel

    init(transitionModel: TodayCustomTransitionModel) {
        self.transitionModel = transitionModel
    }

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return TodayCustomPhotoAnimationController(
                transitionModel: self.transitionModel
            )
        } else {
            return nil
        }
    }
}
