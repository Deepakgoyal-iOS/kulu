//
//  ImageCache.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import UIKit

class ImageCache{
    
    private static var cache = {
        let cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = 100_000_000
        return cache
    }()
    
    static func getImage(forKey key: NSString) -> UIImage? {
        return cache.object(forKey: key)
    }
    
    static func setImage(forKey key: NSString, image: UIImage) {
        cache.setObject(image, forKey: key)
    }
    
}
