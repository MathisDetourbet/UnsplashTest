//
//  UIImageView+Extensions.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import UIKit
import Combine

protocol ImageViewDownloader {
    func fetchImage(at url: URL?, storeIn subscriptions: inout Set<AnyCancellable>)
}

extension UIImageView: ImageViewDownloader {

    func fetchImage(
        at url: URL?,
        storeIn subscriptions: inout Set<AnyCancellable>
    ) {
        guard let url = url else {
            print("[Error]: Image url is nil")
            return
        }

        ImageDownloader.shared.download(at: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] image in
                self?.image = image
            })
            .store(in: &subscriptions)
    }
}
