//
//  TodayNavigationCoordinator.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit

final class TodayNavigationCoordinator: NavigationCoordinator {
    private(set) var children: [Coordinator] = []

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let todayViewController = TodayViewController(nibName: nil, bundle: nil)
        navigationController.setViewControllers([todayViewController], animated: false)
    }
}
