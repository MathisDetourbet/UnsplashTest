//
//  TodayCollectionViewHeaderSectionSupplementaryView.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit

final class TodayCollectionViewHeaderSectionSupplementaryView: UICollectionReusableView, Reusable {
    private let todayDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 35.0)
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

    private func buildUI() {
        self.backgroundColor = .white
        self.setupLabels()
    }

    private func setupLabels() {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(containerView)
        containerView.addSubview(self.todayDateLabel)
        containerView.addSubview(self.titleLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),

            self.todayDateLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.todayDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),

            self.titleLabel.topAnchor.constraint(greaterThanOrEqualTo: self.todayDateLabel.bottomAnchor, constant: 5),
            self.titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

extension TodayCollectionViewHeaderSectionSupplementaryView {

    func fill(with viewModel: TodayCollectionViewHeaderSectionSupplementaryViewModelable) {
        self.todayDateLabel.text = viewModel.todayDateString
        self.titleLabel.text = viewModel.title
    }
}
