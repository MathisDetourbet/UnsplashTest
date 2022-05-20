//
//  TodayDetailsNavigationCoordinator.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation
import UIKit

protocol TodayDetailsCoordinatorDelegate: AnyObject {
    func userDidTapOnClose()
}

final class TodayDetailsNavigationCoordinator: NavigationCoordinator {
    private(set) var children: [Coordinator] = []
    private let dependencies: TodayDetailsDependencies

    let navigationController: UINavigationController
    weak var parent: Coordinator?

    init(
        navigationController: UINavigationController,
        todayDetailsDependencies: TodayDetailsDependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = todayDetailsDependencies
    }

    func start() {
        let todayDetailsFactory = TodayDetailsFactory(
            todayDetailsDependencies: self.dependencies,
            coordinatorDelegate: self
        )
        let todayDetailsViewController = TodayDetailsViewController(factory: todayDetailsFactory)
        todayDetailsViewController.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(todayDetailsViewController, animated: true)
    }

    func stop(coordinator: Coordinator) {}
}

extension TodayDetailsNavigationCoordinator: TodayDetailsCoordinatorDelegate {

    func userDidTapOnClose() {
        self.parent?.stop(coordinator: self)
    }
}
