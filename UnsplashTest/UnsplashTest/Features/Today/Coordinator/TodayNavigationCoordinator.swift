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
        self.navigationController.view.backgroundColor = .blue
    }

    func start() {
        let todayFactory = TodayFactory(todayDependencies: self.dependencies)
        let todayViewController = TodayViewController(factory: todayFactory)
        self.navigationController.setViewControllers([todayViewController], animated: true)
    }
}
