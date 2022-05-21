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
        return 0.35
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
        else {
            transitionContext.completeTransition(false)
            return
        }

        let duration = self.transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)

        let photoImageView = UIImageView(image: self.transitionModel.photoImage)
        photoImageView.frame = self.transitionModel.originFrame
        snapshot.addSubview(photoImageView)
        containerView.addSubview(snapshot)

        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0.0,
            options: .calculationModeCubicPaced,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
                    snapshot.frame = self.transitionModel.finalFrame
                    photoImageView.frame.origin = self.transitionModel.finalFrame.origin
                })
            }) { (_) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
    }
}
