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
        let photosRepository = PhotosRepository(
            httpService: self.dependencies.httpService,
            httpConfiguration: self.dependencies.httpConfiguration
        )
        let fetchTodayFeedUseCase = FetchTodayFeedUseCase(photosRepository: photosRepository)
        let todayViewModel = TodayViewModel(fetchTodayFeedUseCase: fetchTodayFeedUseCase)
        let todayViewController = TodayViewController(viewModel: todayViewModel)
        navigationController.setViewControllers([todayViewController], animated: true)
    }
}
