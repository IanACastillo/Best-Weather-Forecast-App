//
//  ImageLoader.swift
//  Best Weather Forecast App
//
//  Created by Ian Castillo on 27/08/23.
//

import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var urlString: String?
    private var imageCache = ImageCache.getImageCache()

    init(url: String) {
        self.urlString = url
        loadImage()
    }

    func loadImage() {
        if loadImageFromCache() {
            return
        }

        guard let urlString = urlString, let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let _ = response, error == nil else { return }

            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else { return }
                self.imageCache.set(forKey: urlString, image: uiImage)
                self.image = uiImage
            }
        }.resume()
    }

    private func loadImageFromCache() -> Bool {
        guard let urlString = urlString, let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }

        image = cacheImage
        return true
    }
}

class ImageCache {
    private var cache = NSCache<NSString, UIImage>()

    static let shared = ImageCache()

    static func getImageCache() -> ImageCache {
        return shared
    }

    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }

    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
}
