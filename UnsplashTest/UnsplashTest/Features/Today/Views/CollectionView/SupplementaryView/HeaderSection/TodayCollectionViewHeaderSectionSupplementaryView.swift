//
//  TodayCollectionViewHeaderSectionSupplementaryView.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit

final class TodayCollectionViewHeaderSectionSupplementaryView: UICollectionReusableView, Reusable {
    static let reuseIdentifier: String = .init(describing: TodayCollectionViewHeaderSectionSupplementaryView.self)

    private let todayDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildUI() {
        self.backgroundColor = .white
        self.setupLabels()
    }

    private func setupLabels() {
        self.addSubview(self.todayDateLabel)
        self.addSubview(self.titleLabel)

        NSLayoutConstraint.activate([
            self.todayDateLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.todayDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),

            self.titleLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 25),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension TodayCollectionViewHeaderSectionSupplementaryView {

    func fill(with viewModel: TodayCollectionViewHeaderSectionSupplementaryViewModelable) {
        self.todayDateLabel.text = viewModel.todayDateString
        self.titleLabel.text = viewModel.title
    }
}
