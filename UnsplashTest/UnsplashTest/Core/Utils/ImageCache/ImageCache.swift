//
//  ImageCache.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import UIKit

final class ImageCache {

    private let lock = NSLock()

    private lazy var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = Configuration.imagesCountLimit
        cache.totalCostLimit = Configuration.totalMemoryLimit
        return cache
    }()

    // MARK: Store and retrieve image
    func storeImageInCache(_ image: UIImage, for url: URL) {
        self.lock.lock()
        defer { lock.unlock() }
        self.cache.setObject(image, forKey: url.absoluteString as NSString)
    }

    func retrieveImageFromCache(at url: URL) -> UIImage? {
        self.lock.lock()
        defer { self.lock.unlock() }
        return cache.object(forKey: url.absoluteString as NSString)
    }
}


// MARK: - Image cache configuration
private extension ImageCache {

    private enum Configuration {
        static let imagesCountLimit = 100
        static let totalMemoryLimit = 1024 * 1024 * 100
    }
}
