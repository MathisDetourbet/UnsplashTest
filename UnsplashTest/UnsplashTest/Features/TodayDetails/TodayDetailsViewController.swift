//
//  TodayDetailsViewController.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import UIKit
import Combine

final class TodayDetailsViewController: UIViewController {
    private let viewEventSubject: PassthroughSubject<TodayDetailsViewEvent, Never>
    private let viewModel: TodayDetailsViewModel
    private var subscriptions: Set<AnyCancellable> = []
    private var footerViewModel: TodayDetailsCollectionViewFooterSectionSupplementaryViewModelable?

    private lazy var userPhotosCollectionView = self.createCollectionView()
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.closeButtonTap(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        let closeImage = UIImage(named: "close")
        button.setImage(closeImage, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        button.tintColor = .gray
        return button
    }()

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
        self.setupCloseButton()
    }

    private func setupCollectionView() {
        self.userPhotosCollectionView.dataSource = self
        self.userPhotosCollectionView.register(
            supplementaryViewType: TodayDetailsCollectionViewFooterSectionSupplementaryView.self,
            ofKind: UICollectionView.elementKindSectionFooter
        )
        self.userPhotosCollectionView.register(cellType: PhotoDetailsCollectionViewCell.self)
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

    private func setupCloseButton() {
        let backgroundCircleView = UIView()
        backgroundCircleView.backgroundColor = .white
        backgroundCircleView.layer.cornerRadius = 50/2
        backgroundCircleView.clipsToBounds = true
        backgroundCircleView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(backgroundCircleView)
        backgroundCircleView.addSubview(self.closeButton)

        NSLayoutConstraint.activate([
            backgroundCircleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            backgroundCircleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            backgroundCircleView.heightAnchor.constraint(equalToConstant: 50),
            backgroundCircleView.widthAnchor.constraint(equalTo: backgroundCircleView.heightAnchor),


            self.closeButton.centerXAnchor.constraint(equalTo: backgroundCircleView.centerXAnchor),
            self.closeButton.centerYAnchor.constraint(equalTo: backgroundCircleView.centerYAnchor)
        ])
    }

    @objc
    private func closeButtonTap(_ sender: UIButton) {
        self.viewEventSubject.send(.didTapOnClose)
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
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PhotoDetailsCollectionViewCell.self)
        let cellViewModel = self.viewModel.elementAt(indexPath)
        cell.fill(with: cellViewModel)
        return cell
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
        static let cellAspectRatio: CGFloat = 1.0
        static let minimumItemsSpacing: CGFloat = 2.0
        static let minimumLineSpacing: CGFloat = 4.0
        static let collectionHorizontalInset: CGFloat = 2.0
        static let collectionViewMargins: CGFloat = 3.0
        static let footerViewHeight: CGFloat = 120.0
    }

    private func createCollectionView() -> UICollectionView {
        let collectionViewLayout = self.createCollectionViewLayout(with: self.view.frame)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }

    private func createCollectionViewLayout(with frame: CGRect) -> UICollectionViewFlowLayout {
        let itemsHorizontalInset = CollectionViewLayoutProperties.minimumItemsSpacing
        let collectionViewWidth = frame.width - 2 * CollectionViewLayoutProperties.collectionViewMargins

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = self.sizeForItem(collectionViewWidth: collectionViewWidth)
        flowLayout.minimumLineSpacing = CollectionViewLayoutProperties.minimumLineSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: itemsHorizontalInset, bottom: 0.0, right: itemsHorizontalInset)
        flowLayout.minimumInteritemSpacing = CollectionViewLayoutProperties.minimumItemsSpacing
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
