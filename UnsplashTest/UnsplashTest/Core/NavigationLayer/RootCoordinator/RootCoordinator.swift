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
        self.setupTabBarAppearance()
    }

    func start() {
        self.startTodayTab()
        self.setupTodayTabIcon()
    }

    private func setupTabBarAppearance() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().isTranslucent = true
        self.tabBarController.tabBar.layer.borderWidth = 0.5
        self.tabBarController.tabBar.layer.borderColor = UIColor.lightGray.cgColor
        self.tabBarController.tabBar.clipsToBounds = true
    }
}

// MARK: - Today tab
private extension RootCoordinator {

    private func startTodayTab() {
        let navigationController = UINavigationController(rootViewController: TodayViewController())
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
