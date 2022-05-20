//
//  UIImageView+Extensions.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import UIKit
import Combine

protocol ImageViewDownloader {
    func fetchImage(at url: URL)
    func cancelImageDownload()
}

extension UIImageView: ImageViewDownloader {

    func fetchImage(at url: URL) {
        self.imageDownloadSubscription = ImageDownloader.shared.download(from: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("Image has been fetched")
                }
            },
            receiveValue: { [weak self] image in
                self?.image = image
            })
    }

    func cancelImageDownload() {
        self.imageDownloadSubscription?.cancel()
        self.imageDownloadSubscription = nil
    }
}

// MARK: - Image download subscription
fileprivate extension UIImageView {

    struct SubscriptionStoredProperty {
        fileprivate static var _imageDownloadSubscription: AnyCancellable?
    }

    var imageDownloadSubscription: AnyCancellable? {
        get { SubscriptionStoredProperty._imageDownloadSubscription }
        set { SubscriptionStoredProperty._imageDownloadSubscription = newValue }
    }
}
