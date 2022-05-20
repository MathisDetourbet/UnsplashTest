//
//  TodayNavigationCoordinator.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit

protocol TodayNavigationCoordinatorDelegate: AnyObject {
    func userDidSelectPhoto(withId photoId: String, forUsername username: String)
}

final class TodayNavigationCoordinator: NavigationCoordinator {
    private(set) var children: [Coordinator] = []
    private let dependencies: TodayDependencies

    let navigationController: UINavigationController

    init(navigationController: UINavigationController, todayDependencies: TodayDependencies) {
        self.navigationController = navigationController
        self.dependencies = todayDependencies
    }

    func start() {
        let todayFactory = TodayFactory(
            todayDependencies: self.dependencies,
            coordinatorDelegate: self
        )
        let todayViewController = TodayViewController(factory: todayFactory)
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.setViewControllers([todayViewController], animated: true)
    }

    private func startTodayDetails(with dependencies: TodayDetailsDependencies) {
        let todayDetailsCoordinator = TodayDetailsCoordinator(
            navigationController: self.navigationController,
            todayDetailsDependencies: dependencies
        )
        todayDetailsCoordinator.start()
        self.children.append(todayDetailsCoordinator)
    }
}

extension TodayNavigationCoordinator: TodayNavigationCoordinatorDelegate {

    func userDidSelectPhoto(
        withId photoId: String,
        forUsername username: String
    ) {
        let todayDetailsDependencies = TodayDetailsDependencies(
            username: username,
            photoId: photoId,
            photoStatisticsRepository: self.dependencies.photoStatisticsRepository,
            userPhotosRepository: self.dependencies.userPhotosRepository
        )
        self.startTodayDetails(with: todayDetailsDependencies)
    }
}
