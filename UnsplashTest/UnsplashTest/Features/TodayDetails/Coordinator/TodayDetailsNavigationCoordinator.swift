//
//  TodayDetailsCoordinator.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import Foundation
import UIKit

final class TodayDetailsCoordinator: NavigationCoordinator {
    private(set) var children: [Coordinator] = []
    private let dependencies: TodayDetailsDependencies

    let navigationController: UINavigationController

    init(navigationController: UINavigationController, todayDetailsDependencies: TodayDetailsDependencies) {
        self.navigationController = navigationController
        self.dependencies = todayDetailsDependencies
    }

    func start() {
        let todayDetailsFactory = TodayDetailsFactory(todayDetailsDependencies: self.dependencies)
        let todayDetailsViewController = TodayDetailsViewController(factory: todayDetailsFactory)
        self.navigationController.pushViewController(todayDetailsViewController, animated: true)
    }
}
