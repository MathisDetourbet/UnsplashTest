//
//  Coordinator.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get }
    var currentViewController: UIViewController? { get }

    func start()
    func stop(coordinator: Coordinator)
}
