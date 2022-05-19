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
        self.navigationController.view.backgroundColor = .blue
    }

    func start() {
        let todayViewModel = TodayViewModel()
        let todayViewController = TodayViewController(viewModel: todayViewModel)
        navigationController.setViewControllers([todayViewController], animated: true)
    }
}
