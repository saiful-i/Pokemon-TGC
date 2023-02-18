//
//  ImageLoader.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import UIKit
import AlamofireImage

class ImageLoader: ImageProtocol {
    public static var shared: ImageLoader = ImageLoader()
    public static let defaultPlaceholder = "ic_placeholder"
    
    public func attachImage(url: String, into imageView: UIImageView, placeholder: String? = defaultPlaceholder, completion: (() -> ())? = nil, onFailedFetch: Void? = nil) {
        var placeholderImage: UIImage? = nil
        if let imageName = placeholder, !imageName.isEmpty {
            placeholderImage = UIImage(named: imageName)
        }
        guard let url = URL(string: url) else {
            return
        }
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        imageView.af.setImage(withURL: url, placeholderImage: placeholderImage)
    }
}

private protocol ImageProtocol {
    func attachImage(url: String, into imageView: UIImageView, placeholder: String?, completion: (() -> ())?, onFailedFetch: Void?)
}
