//
//  RootCoordinator.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit

final class RootCoordinator: TabBarCoordinator {
    let tabBarController: UITabBarController
    private(set) var children: [Coordinator] = []

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        // TODO: To implement. Init tabs and children coordinators

    }
}
