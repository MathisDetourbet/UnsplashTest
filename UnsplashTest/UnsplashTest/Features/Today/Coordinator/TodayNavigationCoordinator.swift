//
//  TodayNavigationCoordinator.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit

final class TodayNavigationCoordinator: NavigationCoordinator {
    private(set) var children: [Coordinator] = []
    private let dependencies: TodayDependencies

    let navigationController: UINavigationController

    init(navigationController: UINavigationController, todayDependencies: TodayDependencies) {
        self.navigationController = navigationController
        self.dependencies = todayDependencies
    }

    func start() {
        let todayFactory = TodayFactory(todayDependencies: self.dependencies)
        let todayViewController = TodayViewController(factory: todayFactory)
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.setViewControllers([todayViewController], animated: true)
    }
}
