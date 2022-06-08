//
//  TodayDetailsCalculatePhotoCellSizeUseCase.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 31/05/2022.
//

import UIKit

protocol TodayDetailsCalculatePhotoCellSizeUseCaseProtocol {
    func execute() -> CGSize
}

struct TodayDetailsCalculatePhotoCellSizeUseCase: TodayDetailsCalculatePhotoCellSizeUseCaseProtocol {
    private let collectionViewWidth: CGFloat
    private let numberOfItemByRow: UInt
    private let collectionHorizontalInset: CGFloat
    private let cellAspectRatio: CGFloat

    init(
        collectionViewWidth: CGFloat,
        numberOfItemByRow: UInt = TodayDetailsViewController.CollectionViewLayoutProperties.numberOfItemByRow,
        collectionHorizontalInset: CGFloat = TodayDetailsViewController.CollectionViewLayoutProperties.collectionHorizontalInset,
        cellAspectRatio: CGFloat = TodayDetailsViewController.CollectionViewLayoutProperties.cellAspectRatio
    ) {
        self.collectionViewWidth = collectionViewWidth
        self.numberOfItemByRow = numberOfItemByRow
        self.collectionHorizontalInset = collectionHorizontalInset
        self.cellAspectRatio = cellAspectRatio
    }

    func execute() -> CGSize {
        let numberOfItemByRow = CGFloat(self.numberOfItemByRow)
        let itemWidth = self.collectionViewWidth / numberOfItemByRow - 2 * TodayDetailsViewController.CollectionViewLayoutProperties.collectionViewMargins
        let itemHeight = itemWidth * self.cellAspectRatio

        return CGSize(width: itemWidth, height: itemHeight)
    }
}
