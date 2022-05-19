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

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.numberOfLines = 3
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()

    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 4
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, constant: 60).isActive = true
        return imageView
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14.0)
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
        self.layer.cornerRadius = 5.0
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

            // containerView
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 50),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 50),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 50),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 50),

            // descriptionLabel
            self.descriptionLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),

            // userImageView
            self.userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.userImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            // usernameLabel
            self.usernameLabel.leadingAnchor.constraint(equalTo: self.userImageView.trailingAnchor, constant: 22),
            self.usernameLabel.bottomAnchor.constraint(equalTo: self.likesCountLabel.topAnchor, constant: -18),

            // likesCountlabel
            self.likesCountLabel.leadingAnchor.constraint(equalTo: self.userImageView.trailingAnchor, constant: 22),
            self.likesCountLabel.bottomAnchor.constraint(equalTo: self.userImageView.bottomAnchor)
        ])
    }
}

extension PhotoCollectionViewCell {

    func fill(with viewModel: PhotoCellViewModelable) {
        viewModel.backgroundImage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.backgroundImageView.image = image
            }
            .store(in: &self.subscriptions)

        viewModel.userImage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.userImageView.image = image
            }
            .store(in: &self.subscriptions)

        self.descriptionLabel.text = viewModel.description
        self.usernameLabel.text = viewModel.username
        self.likesCountLabel.text = viewModel.likesCountString
    }
}
