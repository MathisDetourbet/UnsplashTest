//
//  TabBarCoordinator.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit

protocol TabBarCoordinator: Coordinator {
    var tabBarController: UITabBarController { get }
}

extension TabBarCoordinator {
    var currentViewController: UIViewController? { self.tabBarController.selectedViewController }
}
