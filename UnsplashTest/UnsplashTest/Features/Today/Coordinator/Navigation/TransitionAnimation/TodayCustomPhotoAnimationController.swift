//
//  TodayCustomPhotoAnimationController.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 21/05/2022.
//

import Foundation
import UIKit

final class TodayCustomPhotoAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    private let transitionModel: TodayCustomTransitionModel

    init(transitionModel: TodayCustomTransitionModel) {
        self.transitionModel = transitionModel
   }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) as? TodayDetailsViewController else {
            transitionContext.completeTransition(false)
            return
        }

        let duration = self.transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        containerView.backgroundColor = .clear
        containerView.addSubview(toVC.view)
        
        let photoImageView = UIImageView(image: self.transitionModel.photoImage)
        photoImageView.frame = self.transitionModel.originalCellFrame
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = PhotoCollectionViewCell.imageCornerRadius
        containerView.addSubview(photoImageView)
        toVC.transitionPhotoImageView = photoImageView

        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0.0,
            options: .calculationModeCubicPaced,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 1/3,
                    animations: {
                        fromVC.tabBarController?.tabBar.alpha = 0.0
                    }
                )
                UIView.addKeyframe(
                    withRelativeStartTime: 1/3,
                    relativeDuration: 1/3,
                    animations: {
                        photoImageView.frame = self.transitionModel.finalCellFrame
                        photoImageView.layer.cornerRadius = 0.0
                    }
                )
            }
        ) { _ in
            fromVC.tabBarController?.tabBar.alpha = 1.0
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
