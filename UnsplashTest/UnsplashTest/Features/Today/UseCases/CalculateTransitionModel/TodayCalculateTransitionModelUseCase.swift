//
//  TodayCalculateTransitionModelUseCase.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 31/05/2022.
//

import UIKit

protocol TodayCalculateTransitionModelUseCaseProtocol {
    func execute() -> TodayCustomTransitionModel?
}

struct TodayCalculateTransitionModelUseCase: TodayCalculateTransitionModelUseCaseProtocol {

    private let todayDetailsCellSizeCalculationUseCase: TodayDetailsCalculatePhotoCellSizeUseCaseProtocol
    private unowned let collectionView: UICollectionView
    private let indexPath: IndexPath
    private unowned let containerView: UIView

    init(
        todayDetailsCellCalculationUseCase: TodayDetailsCalculatePhotoCellSizeUseCaseProtocol,
        collectionView: UICollectionView,
        indexPath: IndexPath,
        containerView: UIView
    ) {
        self.todayDetailsCellSizeCalculationUseCase = todayDetailsCellCalculationUseCase
        self.collectionView = collectionView
        self.indexPath = indexPath
        self.containerView = containerView
    }

    func execute() -> TodayCustomTransitionModel? {
        if let selectedCell = self.collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell {
            let photoImage = selectedCell.backgroundImage ?? UIImage()
            let collectionViewCellFrame = self.collectionView.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
            let containerViewCellFrame = self.containerView.convert(collectionViewCellFrame, from: self.collectionView)

            let margins = TodayDetailsViewController.CollectionViewLayoutProperties.collectionViewMargins
            let additionnalTopInset = UIDevice.hasNotch ? self.containerView.safeAreaInsets.top : 0.0
            let finalCellPoint = CGPoint(x: margins, y: margins + additionnalTopInset)
            let finalCellSize = self.calculateFinalCellSize()
            let finalCellFrame = CGRect(origin: finalCellPoint, size: finalCellSize)

            return .init(
                originalCellFrame: containerViewCellFrame,
                finalCellFrame: finalCellFrame,
                photoImage: photoImage
            )
        } else {
            return nil
        }
    }

    private func calculateFinalCellSize() -> CGSize {
        return self.todayDetailsCellSizeCalculationUseCase.execute()
    }
}
