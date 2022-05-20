//
//  TodayDetailsCollectionViewFooterSectionSupplementaryView.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import UIKit

final class TodayDetailsCollectionViewFooterSectionSupplementaryView: UICollectionReusableView, Reusable {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()

    private let viewsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()

    private let downloadCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()

    private let containerVStackView: UIStackView = {
        let vStackView = UIStackView()
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        vStackView.alignment = .fill
        vStackView.backgroundColor = .clear
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        return vStackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildUI() {
        self.backgroundColor = .white
        self.setupLabels()
    }

    private func setupLabels() {
        self.addSubview(self.containerVStackView)

        let viewsContentStackView = self.createViewsContentStackView()
        let downloadContentStackView = self.createDownloadContentStackView()

        self.containerVStackView.addArrangedSubview(viewsContentStackView)
        self.containerVStackView.addArrangedSubview(downloadContentStackView)

        NSLayoutConstraint.activate([
            self.containerVStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.containerVStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.containerVStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.containerVStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ])
    }

    private func createViewsContentStackView() -> UIStackView {
        let hStackView = UIStackView()
        hStackView.distribution = .fill
        hStackView.alignment = .leading
        hStackView.axis = .horizontal
        hStackView.translatesAutoresizingMaskIntoConstraints = false

        let iconImage = UIImage(named: "eyeIcon")
        let iconImageView = UIImageView(image: iconImage)
        iconImageView.contentMode = .scaleAspectFill

        hStackView.addArrangedSubview(iconImageView)
        hStackView.addArrangedSubview(self.downloadCountLabel)

        return hStackView
    }

    private func createDownloadContentStackView() -> UIStackView {
        let hStackView = UIStackView()
        hStackView.distribution = .fill
        hStackView.alignment = .leading
        hStackView.axis = .horizontal
        hStackView.translatesAutoresizingMaskIntoConstraints = false

        let iconImage = UIImage(named: "download")
        let iconImageView = UIImageView(image: iconImage)
        iconImageView.contentMode = .scaleAspectFill

        hStackView.addArrangedSubview(iconImageView)
        hStackView.addArrangedSubview(self.downloadCountLabel)
        self.containerVStackView.addSubview(hStackView)

        return hStackView
    }
}

extension TodayDetailsCollectionViewFooterSectionSupplementaryView {
    
}

