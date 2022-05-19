//
//  TodayViewController.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit

final class TodayViewController: UIViewController {

    private lazy var photosCollectionView = self.createCollectionView()
    private let viewModel: TodayViewModel

    init(viewModel: TodayViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.setupCollectionView()
    }

    private func setupCollectionView() {
        self.photosCollectionView.dataSource = self
        self.photosCollectionView.delegate = self
        self.photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.photosCollectionView)
        NSLayoutConstraint.activate([
            self.photosCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.photosCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.photosCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.photosCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

// MARK: - Collection view data source
extension TodayViewController: UICollectionViewDataSource {

    func collectionView(_ _: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.numberOfItemsIn(section)
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        self.viewModel.numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: To implement
        fatalError()
    }
}

// MARK: - Collection view delegate
extension TodayViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: To implement
    }
}

// MARK: - Collection view setup
private extension TodayViewController {

    private enum CollectionViewLayoutProperties {
        static let numberOfItemByRow: Int = 1
        static let cellAspectRatio: CGFloat = 533/655
        static let minimumLineSpacing: CGFloat = 50.0
        static let collectionHorizontalInset: CGFloat = 5.0
        static let collectionViewMargins: CGFloat = 5.0
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

        return flowLayout
    }

    private func sizeForItem(collectionViewWidth: CGFloat) -> CGSize {
        let numberOfItemByRow = CGFloat(CollectionViewLayoutProperties.numberOfItemByRow)
        let itemWidth = collectionViewWidth / numberOfItemByRow - CollectionViewLayoutProperties.collectionHorizontalInset
        let itemHeight = itemWidth * CollectionViewLayoutProperties.cellAspectRatio

        return CGSize(width: itemWidth, height: itemHeight)
    }
}
