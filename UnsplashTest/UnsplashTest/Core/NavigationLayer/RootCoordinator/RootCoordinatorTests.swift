//
//  RootCoordinatorTests.swift
//  UnsplashTestTests
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import XCTest
@testable import UnsplashTest

final class RootCoordinatorTests: XCTestCase {

    func test_start_should_add_today_coordinator_child_to_children() {
        // GIVEN
        let rootCoordinator = RootCoordinator(tabBarController: UITabBarController(nibName: nil, bundle: nil))

        // WHEN
        rootCoordinator.start()

        // THEN
        XCTAssertTrue(rootCoordinator.children.first is TodayNavigationCoordinator)
    }

    func test_start_should_set_todayViewController_in_first_tab() throws {
        // GIVEN
        let rootCoordinator = RootCoordinator(tabBarController: UITabBarController(nibName: nil, bundle: nil))

        // WHEN
        rootCoordinator.start()

        // THEN
        let firstNavigationController = try XCTUnwrap(rootCoordinator.tabBarController.selectedViewController as? UINavigationController)
        let firstViewController = firstNavigationController.topViewController
        XCTAssertTrue(firstViewController is TodayViewController)
    }
}
