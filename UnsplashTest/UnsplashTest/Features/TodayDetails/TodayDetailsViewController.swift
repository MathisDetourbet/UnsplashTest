//
//  TodayDetailsViewController.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import UIKit

final class TodayDetailsViewController: UIViewController {
    private lazy var userPhotosCollectionView = self.createCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildUI()
    }

    private func buildUI() {
        self.setupCollectionView()
    }

    private func setupCollectionView() {
        self.userPhotosCollectionView.dataSource = self
        self.userPhotosCollectionView.register(
            supplementaryViewType: TodayDetailsCollectionViewFooterSectionSupplementaryView.self,
            ofKind: UICollectionView.elementKindSectionFooter
        )
        self.userPhotosCollectionView.register(cellType: PhotoCollectionViewCell.self)
        self.userPhotosCollectionView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(self.userPhotosCollectionView)
        NSLayoutConstraint.activate([
            self.userPhotosCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.userPhotosCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.userPhotosCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.userPhotosCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

// MARK: - Collection view data source
extension TodayDetailsViewController: UICollectionViewDataSource {

    func collectionView(_ _: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: To implement
        0
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        // TODO: To implement
        0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: To implement
        fatalError()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            return UICollectionReusableView()
        }
        let footerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            for: indexPath,
            viewType: TodayDetailsCollectionViewFooterSectionSupplementaryView.self
        )
        return footerView
    }
}

// MARK: - Collection view setup
private extension TodayDetailsViewController {

    private enum CollectionViewLayoutProperties {
        static let numberOfItemByRow: Int = 2
        static let cellAspectRatio: CGFloat = 1
        static let minimumLineSpacing: CGFloat = 3
        static let collectionHorizontalInset: CGFloat = 3.0
        static let collectionViewMargins: CGFloat = 3.0
        static let footerViewHeight: CGFloat = 80.0
    }

    private func createCollectionView() -> UICollectionView {
        let collectionViewLayout = self.createCollectionViewLayout(with: self.view.frame)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }

    private func createCollectionViewLayout(with frame: CGRect) -> UICollectionViewFlowLayout {
        let collectionViewWidth = frame.width - 3 * CollectionViewLayoutProperties.collectionViewMargins

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = self.sizeForItem(collectionViewWidth: collectionViewWidth)
        flowLayout.minimumLineSpacing = CollectionViewLayoutProperties.minimumLineSpacing
        flowLayout.scrollDirection = .vertical
        flowLayout.footerReferenceSize = .init(
            width: collectionViewWidth,
            height: CollectionViewLayoutProperties.footerViewHeight
        )

        return flowLayout
    }

    private func sizeForItem(collectionViewWidth: CGFloat) -> CGSize {
        let numberOfItemByRow = CGFloat(CollectionViewLayoutProperties.numberOfItemByRow)
        let itemWidth = collectionViewWidth / numberOfItemByRow - CollectionViewLayoutProperties.collectionHorizontalInset
        let itemHeight = itemWidth * CollectionViewLayoutProperties.cellAspectRatio

        return CGSize(width: itemWidth, height: itemHeight)
    }
}
