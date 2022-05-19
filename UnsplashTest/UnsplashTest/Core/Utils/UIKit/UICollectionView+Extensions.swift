//
//  UICollectionView+Extensions.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit

extension UICollectionView {

    /// Register a Class-Based `UICollectionViewCell` subclass (conforming to `Reusable`)
    ///
    /// - Parameter cellType: the `UICollectionViewCell` (`Reusable`-conforming) subclass to register
    final func register<T: UICollectionViewCell>(cellType: T.Type)
        where T: Reusable {
            self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    /// Returns a reusable `UICollectionViewCell` object for the class inferred by the return-type
    ///
    /// - Parameters:
    ///   - indexPath: The index path specifying the location of the cell.
    ///   - cellType: The cell class to dequeue
    /// - Returns: A `Reusable`, `UICollectionViewCell` instance
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            let bareCell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
            guard let cell = bareCell as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
            }
            return cell
    }

    /// Register a Class-Based `UICollectionReusableView` subclass (conforming to `Reusable`) as a Supplementary View
    ///
    /// - Parameters:
    ///   - supplementaryViewType: the `UIView` (`Reusable`-conforming) subclass to register as Supplementary View
    ///   - elementKind: The kind of supplementary view to create.
    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String)
        where T: Reusable {
            self.register(
                supplementaryViewType.self,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: supplementaryViewType.reuseIdentifier
            )
    }

    /// Returns a reusable `UICollectionReusableView` object for the class inferred by the return-type
    ///
    /// - Parameters:
    ///   - elementKind: The kind of supplementary view to retrieve.
    ///   - indexPath: The index path specifying the location of the supplementary view.
    ///   - viewType: The view class to dequeue
    /// - Returns: A `Reusable`, `UICollectionReusableView` instance
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>
        (ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T
        where T: Reusable {
            let view = self.dequeueReusableSupplementaryView(
                ofKind: elementKind,
                withReuseIdentifier: viewType.reuseIdentifier,
                for: indexPath
            )
            guard let typedView = view as? T else {
                fatalError(
                    "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) "
                        + "matching type \(viewType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the supplementary view beforehand"
                )
            }
            return typedView
    }
}
