//
//  TodayViewController.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit
import Combine

final class TodayViewController: UIViewController {

    private lazy var photosCollectionView = self.createCollectionView()
    private let viewModel: TodayViewModel
    private let viewEventSubject: PassthroughSubject<TodayViewEvent, Never>
    private var subscriptions: Set<AnyCancellable> = []

    init(factory: TodayFactoryProtocol) {
        let viewEventInputSubject = PassthroughSubject<TodayViewEvent, Never>()
        self.viewModel = factory.createViewModel(
            viewEventPublisher: viewEventInputSubject.eraseToAnyPublisher()
        )
        self.viewEventSubject = viewEventInputSubject
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.setupCollectionView()
        self.bindToViewModelOutput()

        self.viewEventSubject.send(.viewDidLoad)
    }

    private func setupCollectionView() {
        self.photosCollectionView.dataSource = self
        self.photosCollectionView.delegate = self
        self.photosCollectionView.register(
            TodayCollectionViewHeaderSectionSupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TodayCollectionViewHeaderSectionSupplementaryView.reuseIdentifier
        )
        self.photosCollectionView.register(cellType: PhotoCollectionViewCell.self)
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

// MARK: - ViewModel binding
private extension TodayViewController {

    private func bindToViewModelOutput() {
        self.subscriptions = []

        self.viewModel
            .output
            .reloadPhotosPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.photosCollectionView.reloadData()
            }
            .store(in: &self.subscriptions)
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
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PhotoCollectionViewCell.self)
        let cellViewModel = self.viewModel.elementAt(indexPath)
        cell.fill(with: cellViewModel)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            for: indexPath,
            viewType: TodayCollectionViewHeaderSectionSupplementaryView.self
        )
        let headerViewModel = self.viewModel.output.headerViewModel
        headerView.fill(with: headerViewModel)
        return headerView
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
        static let minimumLineSpacing: CGFloat = 30.0
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
