//
//  AppDelegate.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var rootCoordinator: RootCoordinator?

    func application(
        _ _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let tabBarController = UITabBarController()
        self.initWindow(with: tabBarController)
        self.startRootCoordinator(with: tabBarController)

        return true
    }

    private func initWindow(with rootViewController: UITabBarController) {
        let window = UIWindow()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }

    private func startRootCoordinator(with tabBarController: UITabBarController) {
        self.rootCoordinator = RootCoordinator(tabBarController: tabBarController)
        self.rootCoordinator?.start()
    }
}
