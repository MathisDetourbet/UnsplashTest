//
//  ImageDownloader.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit
import Combine

final class ImageDownloader {

    enum DownloadError: Error {
        case noResponseData
        case requestFailed
        case invalidData
        case unkwnown(Error)

        init(error: Error) {
            self = .unkwnown(error)
        }
    }

    static var shared = ImageDownloader()

    private var cache = ImageCache()
    private let successCodeRange = 200..<300

    func download(at url: URL) -> AnyPublisher<UIImage, DownloadError> {
        if let cachedImage = self.cache.retrieveImageFromCache(at: url) {
            return Just(cachedImage)
                .setFailureType(to: DownloadError.self)
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .tryMap { data throws -> UIImage in
                guard let image = UIImage(data: data) else {
                    throw DownloadError.invalidData
                }
                return image
            }
            .mapError(DownloadError.init)
            .eraseToAnyPublisher()
    }
}

