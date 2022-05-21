//
//  PhotoCollectionViewCell.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit
import Combine

final class PhotoCollectionViewCell: UICollectionViewCell, Reusable {
    private var subscriptions: Set<AnyCancellable> = []

    var backgroundImage: UIImage? { self.backgroundImageView.image }

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 3
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()

    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 60/2
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        return imageView
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()

    private let likesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
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

        self.backgroundImageView.image = nil
        self.userImageView.image = nil
        self.descriptionLabel.text = nil
        self.usernameLabel.text = nil
        self.likesCountLabel.text = nil
    }

    private func buildUI() {
        self.setupCell()
        self.setupLayout()
    }

    private func setupCell() {
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }

    private func setupLayout() {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.backgroundImageView)
        self.contentView.addSubview(containerView)

        containerView.addSubview(self.descriptionLabel)
        containerView.addSubview(self.usernameLabel)
        containerView.addSubview(self.userImageView)
        containerView.addSubview(self.likesCountLabel)

        NSLayoutConstraint.activate([
            // backgroundImageView
            self.backgroundImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

            // containerVStackView
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),

            // descriptionLabel
            self.descriptionLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            // userImageView
            self.userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.userImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            // usernameLabel
            self.usernameLabel.leadingAnchor.constraint(equalTo: self.userImageView.trailingAnchor, constant: 22),
            self.usernameLabel.bottomAnchor.constraint(equalTo: self.likesCountLabel.topAnchor, constant: -5),

            // likesCountlabel
            self.likesCountLabel.leadingAnchor.constraint(equalTo: self.userImageView.trailingAnchor, constant: 22),
            self.likesCountLabel.bottomAnchor.constraint(equalTo: self.userImageView.bottomAnchor)
        ])
    }
}

extension PhotoCollectionViewCell {

    func fill(with viewModel: PhotoCellViewModelable) {
        self.subscriptions = []
        
        self.backgroundImageView.fetchImage(
            at: viewModel.backgroundImageURL,
            storeIn: &self.subscriptions
        )
        self.userImageView.fetchImage(
            at: viewModel.userImageURL,
            storeIn: &self.subscriptions
        )

        self.descriptionLabel.text = viewModel.description
        self.usernameLabel.text = viewModel.username
        self.likesCountLabel.text = viewModel.likesCountString
    }
}
