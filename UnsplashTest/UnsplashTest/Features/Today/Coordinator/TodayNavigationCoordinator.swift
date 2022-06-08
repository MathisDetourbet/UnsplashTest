//
//  TodayNavigationCoordinator.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit

protocol TodayNavigationCoordinatorDelegate: AnyObject {
    func userDidSelectPhoto(
        photoViewModel: PhotoViewModel,
        transitionModel: TodayCustomTransitionModel?
    )
}

final class TodayNavigationCoordinator: NavigationCoordinator {
    private(set) var children: [Coordinator] = []
    private let dependencies: TodayDependencies
    private var todayCustomPhotoTransitionNavigationController: TodayCustomPhotoTransitionNavigationController?

    let navigationController: UINavigationController

    init(
        navigationController: UINavigationController,
        todayDependencies: TodayDependencies
    ) {
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

    func stop(coordinator: Coordinator) {
        self.children.removeAll { child in
            coordinator === child
        }
        self.navigationController.popViewController(animated: true)
    }

    private func startTodayDetails(
        with dependencies: TodayDetailsDependencies,
        transitionModel: TodayCustomTransitionModel? = nil
    ) {
        if let transitionModel = transitionModel {
            self.todayCustomPhotoTransitionNavigationController = TodayCustomPhotoTransitionNavigationController(transitionModel: transitionModel
            )
            self.navigationController.delegate = self.todayCustomPhotoTransitionNavigationController
        }

        let todayDetailsCoordinator = TodayDetailsNavigationCoordinator(
            navigationController: self.navigationController,
            todayDetailsDependencies: dependencies
        )
        todayDetailsCoordinator.start()
        todayDetailsCoordinator.parent = self
        self.children.append(todayDetailsCoordinator)
    }
}

extension TodayNavigationCoordinator: TodayNavigationCoordinatorDelegate {

    func userDidSelectPhoto(
        photoViewModel: PhotoViewModel,
        transitionModel: TodayCustomTransitionModel? = nil
    ) {
        let todayDetailsDependencies = TodayDetailsDependencies(
            photoViewModel: photoViewModel,
            photoStatisticsRepository: self.dependencies.photoStatisticsRepository,
            userPhotosRepository: self.dependencies.userPhotosRepository
        )
        self.startTodayDetails(
            with: todayDetailsDependencies,
            transitionModel: transitionModel
        )
    }
}
