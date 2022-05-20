//
//  PhotoDetailsCollectionViewCell.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 21/05/2022.
//

import UIKit
import Combine

final class PhotoDetailsCollectionViewCell: UICollectionViewCell, Reusable {
    private var subscriptions: Set<AnyCancellable> = []

    private let photoDetailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.subscriptions = []
        self.photoDetailImageView.image = nil
    }

    private func buildUI() {
        self.contentView.clipsToBounds = true
        
        self.contentView.addSubview(self.photoDetailImageView)
        NSLayoutConstraint.activate([
            self.photoDetailImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.photoDetailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.photoDetailImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.photoDetailImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}

extension PhotoDetailsCollectionViewCell {

    func fill(with viewModel: PhotoDetailsViewModelable) {
        self.subscriptions = []

        self.photoDetailImageView.fetchImage(
            at: viewModel.imageURL,
            storeIn: &self.subscriptions
        )
    }
}
