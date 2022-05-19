//
//  RootCoordinator.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit

final class RootCoordinator: TabBarCoordinator {
    private(set) var children: [Coordinator] = []

    let tabBarController: UITabBarController

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        self.startTodayTab()
    }

    // MARK: Today tab
    private func startTodayTab() {
        let navigationController = UINavigationController(nibName: nil, bundle: nil)
        let todayCoordinator = TodayNavigationCoordinator(navigationController: navigationController)

        guard let todayViewController = todayCoordinator.currentViewController else {
            return
        }

        todayCoordinator.start()
        self.children.append(todayCoordinator)
        self.tabBarController.setViewControllers([todayViewController], animated: true)
        self.setupTodayTabIcon()
    }

    private func setupTodayTabIcon() {
        guard let todayTabBarItem = self.tabBarItemFor(.today) else {
            return
        }

        todayTabBarItem.title = "Today"
        todayTabBarItem.image = UIImage(named: "today")
        todayTabBarItem.selectedImage = UIImage(named: "today")
    }
}

// MARK: - Tab management
private extension RootCoordinator {

    private enum Tab {
        case today

        var tabBarItemIndex: Int {
            switch self {
            case .today:
                return 0
            }
        }
    }

    private func tabBarItemFor(_ tab: Tab) -> UITabBarItem? {
        return self.tabBarController.tabBar.items?[tab.tabBarItemIndex]
    }
}
