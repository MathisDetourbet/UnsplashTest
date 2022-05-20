//
//  TodayDetailsViewController.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import UIKit
import Combine

final class TodayDetailsViewController: UIViewController {
    private lazy var userPhotosCollectionView = self.createCollectionView()
    private let viewEventSubject: PassthroughSubject<TodayDetailsViewEvent, Never>
    private let viewModel: TodayDetailsViewModel
    private var subscriptions: Set<AnyCancellable> = []
    private var footerViewModel: TodayDetailsCollectionViewFooterSectionSupplementaryViewModelable?

    init(factory: TodayDetailsFactoryProtocol) {
        let viewEventSubject = PassthroughSubject<TodayDetailsViewEvent, Never>()
        self.viewModel = factory.createViewModel(
            viewEventPublisher: viewEventSubject.eraseToAnyPublisher()
        )
        self.viewEventSubject = viewEventSubject
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildUI()
        self.bindToViewModelOutput()
        self.viewEventSubject.send(.viewDidLoad)
    }

    private func buildUI() {
        self.view.backgroundColor = .white
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

// MARK: - ViewModel binding
private extension TodayDetailsViewController {

    private func bindToViewModelOutput() {
        self.subscriptions = []

        self.viewModel
            .output
            .reloadPhotosPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.userPhotosCollectionView.performBatchUpdates({
                    self?.userPhotosCollectionView.reloadSections(IndexSet(integer: 0))
                })
            }
            .store(in: &self.subscriptions)

        self.viewModel
            .output
            .footerViewModelPublisher
            .sink { [weak self] completion in
                switch completion {
                case .failure:
                    self?.footerViewModel = nil
                default:
                    break
                }
            } receiveValue: { [weak self] footerViewModel in
                self?.footerViewModel = footerViewModel
            }
            .store(in: &self.subscriptions)

    }
}

// MARK: - Collection view data source
extension TodayDetailsViewController: UICollectionViewDataSource {

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
        if let footerViewModel = self.footerViewModel {
            footerView.fill(with: footerViewModel)
        }
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
